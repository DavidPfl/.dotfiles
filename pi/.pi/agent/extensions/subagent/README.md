# Subagent model preferences

In an agent definition's YAML frontmatter, `model` can be an ordered list:

```yaml
---
name: reviewer
description: Reviews code
model:
  - opencode-go/glm-5.3-flash
  - deepseek/deepseek-v4-pro
  - anthropic/claude-sonnet-4-6
---
```

The first model available to the current Pi session is used. A single model (`model: deepseek-v4-pro`) and a comma-separated string also work. Prefer `provider/model-id` when multiple providers offer the same model ID. If none of the configured models is available, the subagent fails with the attempted list instead of silently using the parent's model. Without `model`, it inherits the parent's model and thinking level. This selects a model before launching the subagent; it does not retry after a model request fails.
