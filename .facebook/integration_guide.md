# OCamlFormat Integration Guide for Facebook Projects

## Overview
This document provides guidelines for integrating OCamlFormat into Facebook open source projects, particularly those written in OCaml or using OCaml tooling.

## Installation for Facebook Projects

### Using Facebook's Internal Package Manager
```bash
# For internal projects
facebook-pkg install ocamlformat
```

### Using Standard OPAM
```bash
# For open source projects
opam install ocamlformat
```

## Configuration

### Recommended .ocamlformat Configuration
```
version=0.26.2
profile=conventional
margin=100
```

### For Facebook Infer Project
The Infer project uses OCamlFormat with specific settings optimized for the codebase:
- Profile: conventional
- Margin: 90 characters
- Version pinning: Enabled

## Integration with CI/CD

### Buck Integration
Add to your BUCK file:
```python
ocaml_binary(
    name = "format_check",
    deps = [":ocamlformat"],
)
```

### Continuous Integration
Add format checking to your CI pipeline:
```bash
#!/bin/bash
# Check if code is properly formatted
dune build @fmt
```

## Editor Setup

### VS Code (Facebook Internal)
1. Install OCaml Platform extension
2. Configure settings.json:
```json
{
  "ocaml.format.enable": true,
  "ocaml.format.tool": "ocamlformat"
}
```

### Nuclide (Legacy)
Add to your Nuclide config:
```json
{
  "ocaml.formatOnSave": true,
  "ocaml.formatter": "ocamlformat"
}
```

## Best Practices

### 1. Version Pinning
Always pin the OCamlFormat version in your .ocamlformat file:
```
version=0.26.2
```

### 2. Incremental Adoption
- Start with new files only
- Use .ocamlformat-ignore for legacy code
- Gradually expand formatting coverage

### 3. Team Communication
- Announce OCamlFormat adoption in advance
- Provide training sessions
- Create documentation for team-specific configurations

### 4. Code Review Integration
- Add pre-commit hooks to check formatting
- Use CI to enforce formatting rules
- Provide helpful error messages

## Troubleshooting

### Common Issues

#### Issue: Formatting changes too much code
**Solution**: Use .ocamlformat-ignore to exclude files temporarily

#### Issue: Version conflicts
**Solution**: Ensure all team members use the same OCamlFormat version

#### Issue: Performance concerns
**Solution**: Use incremental formatting in CI, only check changed files

## Support

### Internal Support
- Post in the #ocaml or #developer-tools workplace groups
- Contact the OCaml Platform team

### External Support
- GitHub Issues: https://github.com/ocaml-ppx/ocamlformat/issues
- OCaml Discourse: https://discuss.ocaml.org/tags/ocamlformat

## Migration Examples

### From Manual Formatting
```bash
# Format entire project
find . -name "*.ml" -o -name "*.mli" | xargs ocamlformat -i

# Commit formatted code
git add .
git commit -m "Format code with OCamlFormat"
```

### From Ocp-indent
1. Remove ocp-indent configuration
2. Add .ocamlformat configuration
3. Run formatting: `dune build @fmt --auto-promote`

## Performance Considerations

### Large Codebases
- OCamlFormat scales well to large codebases
- Facebook Infer (600k+ lines) uses OCamlFormat successfully
- Parallel processing available with appropriate flags

### CI Optimization
```bash
# Only format changed files
git diff --name-only --diff-filter=ACMR origin/main | grep "\.mli\?$" | xargs ocamlformat --check
```

## Updates and Versioning

### Staying Current
- Monitor OCamlFormat releases
- Test new versions in isolated branches
- Update gradually across projects

### Breaking Changes
- Review CHANGES.md for each release
- Test formatting output before upgrading
- Communicate changes to team

## Contributing Back

Facebook encourages contributing improvements back to OCamlFormat:
1. Follow the CONTRIBUTING.md guidelines
2. Submit pull requests to upstream
3. Participate in design discussions
4. Share feedback on new features

---

**Document Version**: 1.0  
**Last Updated**: 2025-12-25  
**Maintainer**: Facebook Open Source Team
