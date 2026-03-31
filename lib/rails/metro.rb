require_relative "metro/version"
require_relative "metro/config"
require_relative "metro/feature_pack"
require_relative "metro/feature_registry"
require_relative "metro/template_compiler"
require_relative "metro/cli"

# Eagerly load all built-in packs
Rails::Metro::FeatureRegistry.load_builtin_packs
