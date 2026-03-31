# Security Policy

## Supported Versions

Only the latest release published to RubyGems is actively supported with security fixes.

| Version | Supported |
|---------|-----------|
| latest  | Yes       |
| older   | No        |

## Reporting a Vulnerability

**Please do not report security vulnerabilities via public GitHub issues.**

Report vulnerabilities using [GitHub's private security advisory feature](https://github.com/rish/rails-metro/security/advisories/new). You'll receive a response within 7 days.

### What to include

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix if you have one

### Scope

rails-metro is a code generator — it produces Rails Application Templates that users run locally. The main security surface is the content of generated template files and the packs that define them. Reports about generated code that could introduce vulnerabilities into user applications are in scope.
