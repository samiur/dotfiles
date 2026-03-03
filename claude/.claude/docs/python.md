## Python

- Prefer using uv for everything (uv add, uv run, etc)
- Do not use old fashioned methods for package management like poetry, pip or easy_install.
- Make sure that there is a pyproject.toml file in the root directory.
- If there isn't a pyproject.toml file, create one using uv by running uv init.
- All python code should be type checked using mypy, linted and formatting checked using ruff, and have testing using pytest.
- For any LLM processing, we can primarily use OpenAI (gpt5 and variants).
- If we need a structured response, we should use the OpenAI responses API with defined Pydantic schemas.
- If we need to do any templating for prompts, we should use Jinja.
- Write async-first Python code
- Use FastAPI for building APIs
- Use SQLModel for an ORM. Some documentation here: https://sqlmodel.tiangolo.com/
- Use Pydantic for schemas/modeling
- Use Alembic for managing migrations
- Try to always use the ORM to query the DB, and avoid using raw SQL unless absolutely necessary.
- To parse/convert documents, use docling: https://docling-project.github.io/docling/
- When creating AI agents, use Agno. Documentation available here: @~/.claude/docs/agno.md

### Tools guidelines

#### Pydantic

- **Always use `Annotated[Type, Field(...)]`** - never put Field directly on the type
- **Place defaults outside Field()** - `= value` or `= Field(default_factory=func)`
- **Import Annotated** - `from typing import Annotated`
- **ALWAYS use enums instead of regex patterns for finite sets of string values.** This is especially important for LLM structured output (OpenAI function calling) because:
  - Enums generate cleaner JSON schemas that LLMs understand better
  - Prevents validation errors from unexpected values (e.g., "N/A" instead of valid enum)
  - Eliminates retry loops from validation failures
  - Provides better type safety and IDE support
- Make sure to use pydantic-mypy plugin


### Typing/mypy
- **Use modern union syntax** - `str | None` instead of `Optional[str]`
- **Use enums instead of regex patterns** - for finite sets of string values (see Enum section below)
