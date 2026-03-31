## What does this PR do?

<!-- Brief description of the change -->

## Type of change

- [ ] New pack
- [ ] Pack improvement / bug fix
- [ ] Core feature (CLI, TUI, FeatureRegistry, TemplateCompiler)
- [ ] Tests / docs

## Checklist

- [ ] `bundle exec rake test` passes
- [ ] `bundle exec rake standard` passes
- [ ] New pack defines: `pack_name`, `description`, `category`, `gems`, `template_lines`, `post_install_notes`
- [ ] Conflict symmetry maintained — if this pack declares `conflicts_with "x"`, pack `x` also declares `conflicts_with` back
- [ ] `depends_on` references exist in the registry
- [ ] Golden files regenerated if template output changed (`test/golden/expected/`)
