require "test_helper"

class Rails::Metro::FeatureRegistryTest < Minitest::Test
  def setup
    @registry = Rails::Metro::FeatureRegistry.new
  end

  def test_register_and_find
    @registry.register(Rails::Metro::Packs::PosthogPack)
    assert_equal Rails::Metro::Packs::PosthogPack, @registry.find("posthog")
  end

  def test_names
    @registry.register(Rails::Metro::Packs::PosthogPack)
    @registry.register(Rails::Metro::Packs::BlazerPack)
    assert_equal ["blazer", "posthog"], @registry.names
  end

  def test_categories
    @registry.register(Rails::Metro::Packs::PosthogPack)
    @registry.register(Rails::Metro::Packs::ChartingPack)
    cats = @registry.categories
    assert_includes cats.keys, "analytics"
    assert_includes cats.keys, "ui"
  end

  def test_resolve_returns_pack_classes
    @registry.register(Rails::Metro::Packs::PosthogPack)
    @registry.register(Rails::Metro::Packs::BlazerPack)
    resolved = @registry.resolve(["posthog", "blazer"])
    assert_equal 2, resolved.length
    assert(resolved.all? { |p| p < Rails::Metro::FeaturePack })
  end

  def test_resolve_unknown_pack_raises
    @registry.register(Rails::Metro::Packs::PosthogPack)
    assert_raises(Rails::Metro::FeatureRegistry::DependencyError) do
      @registry.resolve(["nonexistent"])
    end
  end

  def test_resolve_with_dependencies
    dep_pack = Class.new(Rails::Metro::FeaturePack) do
      pack_name "dep_pack"
    end
    main_pack = Class.new(Rails::Metro::FeaturePack) do
      pack_name "main_pack"
      depends_on "dep_pack"
    end

    @registry.register(dep_pack)
    @registry.register(main_pack)

    resolved = @registry.resolve(["main_pack"])
    assert_equal 2, resolved.length
    assert_equal "dep_pack", resolved[0].pack_name
    assert_equal "main_pack", resolved[1].pack_name
  end

  def test_resolve_circular_dependency_raises
    pack_a = Class.new(Rails::Metro::FeaturePack) do
      pack_name "pack_a"
      depends_on "pack_b"
    end
    pack_b = Class.new(Rails::Metro::FeaturePack) do
      pack_name "pack_b"
      depends_on "pack_a"
    end

    @registry.register(pack_a)
    @registry.register(pack_b)

    assert_raises(Rails::Metro::FeatureRegistry::DependencyError) do
      @registry.resolve(["pack_a"])
    end
  end

  def test_resolve_conflict_raises
    pack_a = Class.new(Rails::Metro::FeaturePack) do
      pack_name "pack_a"
      conflicts_with "pack_b"
    end
    pack_b = Class.new(Rails::Metro::FeaturePack) do
      pack_name "pack_b"
    end

    @registry.register(pack_a)
    @registry.register(pack_b)

    assert_raises(Rails::Metro::FeatureRegistry::ConflictError) do
      @registry.resolve(["pack_a", "pack_b"])
    end
  end

  def test_default_registry_loads_builtin_packs
    registry = Rails::Metro::FeatureRegistry.default
    assert registry.names.include?("posthog")
    assert registry.names.include?("blazer")
    assert registry.names.include?("charting")
  end

  def test_as_catalog_returns_array_of_hashes
    @registry.register(Rails::Metro::Packs::PosthogPack)
    @registry.register(Rails::Metro::Packs::BlazerPack)
    catalog = @registry.as_catalog
    assert_kind_of Array, catalog
    assert_equal 2, catalog.length

    entry = catalog.find { |e| e[:name] == "posthog" }
    assert entry
    assert_equal "PostHog product analytics (server-side + JS snippet)", entry[:description]
    assert_equal "analytics", entry[:category]
    assert_kind_of Array, entry[:depends_on]
    assert_kind_of Array, entry[:conflicts_with]
  end

  def test_as_catalog_sorted_by_name
    @registry.register(Rails::Metro::Packs::PosthogPack)
    @registry.register(Rails::Metro::Packs::BlazerPack)
    catalog = @registry.as_catalog
    assert_equal "blazer", catalog[0][:name]
    assert_equal "posthog", catalog[1][:name]
  end

  def test_validate_selection_valid
    @registry.register(Rails::Metro::Packs::PosthogPack)
    @registry.register(Rails::Metro::Packs::BlazerPack)
    result = @registry.validate_selection(["posthog", "blazer"])
    assert result[:valid]
    assert_empty result[:errors]
    assert_empty result[:auto_added]
  end

  def test_validate_selection_unknown_pack
    @registry.register(Rails::Metro::Packs::PosthogPack)
    result = @registry.validate_selection(["nonexistent"])
    refute result[:valid]
    assert result[:errors].any? { |e| e.include?("Unknown") }
  end

  def test_validate_selection_conflict
    pack_a = Class.new(Rails::Metro::FeaturePack) do
      pack_name "val_pack_a"
      conflicts_with "val_pack_b"
    end
    pack_b = Class.new(Rails::Metro::FeaturePack) do
      pack_name "val_pack_b"
    end
    @registry.register(pack_a)
    @registry.register(pack_b)

    result = @registry.validate_selection(["val_pack_a", "val_pack_b"])
    refute result[:valid]
    assert result[:errors].any? { |e| e.include?("conflicts") }
  end

  def test_validate_selection_auto_adds_dependencies
    dep_pack = Class.new(Rails::Metro::FeaturePack) do
      pack_name "val_dep"
    end
    main_pack = Class.new(Rails::Metro::FeaturePack) do
      pack_name "val_main"
      depends_on "val_dep"
    end
    @registry.register(dep_pack)
    @registry.register(main_pack)

    result = @registry.validate_selection(["val_main"])
    assert result[:valid]
    assert_includes result[:auto_added], "val_dep"
  end
end
