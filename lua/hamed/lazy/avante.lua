return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        provider = "claude",
        openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-4o",             -- your desired model (or use gpt-4o, etc.)
            timeout = 30000,              -- Timeout in milliseconds, increase this for reasoning models
            temperature = 0,
            max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
            --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
        claude = {
            model = "claude-3-5-sonnet-20241022",
            max_tokens = 4096,
            temperature = 0,
            -- disable_tools = true,
        },
        web_search_engine = {
            provider = 'serpapi',
        },
        rag_service = {
            enabled = false, -- Enables the rag service, requires OPENAI_API_KEY to be set
            host_mount = os.getenv("HOME"),
            provider = 'claude',
            -- llm_model = 'gpt-4o',
            -- embed_model = 'gpt-4o',
            -- endpoint = 'https://api.openai.com/v1',
            endpoint = 'https://api.anthropic.com',
        },
        -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
        system_prompt = function()
            local system_prompt = [[
Follow these steps for each interaction:

1. User Identification:
   - You should assume that you are interacting with default_user
   - If you have not identified default_user, proactively try to do so.

2. Memory Retrieval:
   - Always begin your chat by saying only "Remembering..." and retrieve all relevant information from your knowledge graph
   - Always refer to your knowledge graph as your "memory"

3. Memory
   - While conversing with the user, be attentive to any new information that falls into these categories:
     a) Basic Identity (age, gender, location, job title, education level, etc.)
     b) Behaviors (interests, habits, etc.)
     c) Preferences (communication style, preferred language, etc.)
     d) Goals (goals, targets, aspirations, etc.)
     e) Relationships (personal and professional relationships up to 3 degrees of separation)

4. Memory Update:
   - If any new information was gathered during the interaction, update your memory as follows:
     a) Create entities for recurring organizations, people, and significant events
     b) Connect them to the current entities using relations
     b) Store facts about them as observations
        ]]
            local hub = require('mcphub').get_hub_instance()
            return system_prompt .. '\n\n' .. hub:get_active_servers_prompt()
        end,
        -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
        custom_tools = function()
            return {
                require('mcphub.extensions.avante').mcp_tool(),
            }
        end,
        -- auto_suggestions_provider = 'copilot',
        -- cursor_applying_provider = 'groq',
        -- memory_summary_provider = 'openai-gpt-4o-mini',
        -- file_selector = {
        --     provider = 'telescope',
        --     -- Options override for custom providers
        --     provider_opts = {},
        -- },
        behaviour = {
            enable_claude_text_editor_tool_mode = true,
        --     auto_focus_sidebar = true,
        --     auto_suggestions = false,
        --     minimize_diff = true,
        --     enable_token_counting = false,
        --     enable_cursor_planning_mode = false,
        --     -- enable_claude_text_editor_tool_mode = true,
        --     enable_claude_text_editor_tool_mode = false,
        --     use_cwd_as_project_root = true,
        },
        -- windows = {
        --     position = 'smart',
        --     height = 46,
        --     wrap = true,
        --     sidebar_header = {
        --         align = 'center',
        --     },
        --     ask = {
        --         floating = false,
        --     },
        -- },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick",         -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua",              -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",        -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
