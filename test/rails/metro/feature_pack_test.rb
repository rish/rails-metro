require "test_helper"

class Rails::Metro::FeaturePackTest < Minitest::Test
  def test_posthog_pack
    pack = Rails::Metro::Packs::PosthogPack.new
    gem_names = pack.gems.map { |g| g[:name] }
    assert_includes gem_names, "posthog-ruby"
    assert_includes gem_names, "posthog-rails"
    assert pack.template_lines.any?
    assert pack.post_install_notes.any?
    assert_equal "analytics", Rails::Metro::Packs::PosthogPack.category
  end

  def test_blazer_pack
    pack = Rails::Metro::Packs::BlazerPack.new
    gem_names = pack.gems.map { |g| g[:name] }
    assert_includes gem_names, "blazer"
    assert pack.template_lines.any? { |l| l.include?("blazer:install") }
    assert_equal "analytics", Rails::Metro::Packs::BlazerPack.category
  end

  def test_charting_pack
    pack = Rails::Metro::Packs::ChartingPack.new
    gem_names = pack.gems.map { |g| g[:name] }
    assert_includes gem_names, "chartkick"
    assert_includes gem_names, "groupdate"
    assert_equal "ui", Rails::Metro::Packs::ChartingPack.category
  end

  def test_all_packs_have_required_metadata
    Rails::Metro::FeatureRegistry.load_builtin_packs
    Rails::Metro::FeatureRegistry.builtin_pack_classes.each do |klass|
      assert klass.pack_name, "#{klass} missing pack_name"
      assert klass.description, "#{klass} missing description"
      assert klass.category, "#{klass} missing category"

      instance = klass.new
      assert_kind_of Array, instance.gems
      assert_kind_of Array, instance.template_lines
      assert_kind_of Array, instance.post_install_notes
    end
  end

  def test_all_packs_gems_have_name
    Rails::Metro::FeatureRegistry.load_builtin_packs
    Rails::Metro::FeatureRegistry.builtin_pack_classes.each do |klass|
      klass.new.gems.each do |gem_decl|
        assert gem_decl[:name], "#{klass.pack_name} has a gem without a name"
      end
    end
  end

  def test_no_duplicate_pack_names
    registry = Rails::Metro::FeatureRegistry.default
    names = registry.all.map(&:pack_name)
    duplicates = names.select { |n| names.count(n) > 1 }.uniq
    assert_empty duplicates, "Duplicate pack names: #{duplicates.join(", ")}"
  end

  def test_all_depends_on_references_exist
    registry = Rails::Metro::FeatureRegistry.default
    registry.all.each do |pack|
      pack.depends_on.each do |dep|
        assert registry.find(dep),
          "#{pack.pack_name} depends_on '#{dep}' which does not exist"
      end
    end
  end

  def test_all_conflicts_with_references_exist
    registry = Rails::Metro::FeatureRegistry.default
    registry.all.each do |pack|
      pack.conflicts_with.each do |conflict|
        assert registry.find(conflict),
          "#{pack.pack_name} conflicts_with '#{conflict}' which does not exist"
      end
    end
  end

  def test_conflict_symmetry
    registry = Rails::Metro::FeatureRegistry.default
    registry.all.each do |pack|
      pack.conflicts_with.each do |conflict_name|
        other = registry.find(conflict_name)
        next unless other
        assert_includes other.conflicts_with, pack.pack_name,
          "#{pack.pack_name} conflicts_with '#{conflict_name}' but '#{conflict_name}' does not conflict back"
      end
    end
  end
end
