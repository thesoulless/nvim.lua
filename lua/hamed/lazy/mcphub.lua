return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    config = function()
        local config = vim.fn.expand("~/mcpservers.json")
        local curr_config = vim.fn.expand("%:p:h") .. "/mcpservers.json"
        local final_config = vim.fn.filereadable(curr_config) == 1 and curr_config or config

        if vim.fn.filereadable(final_config) == 0 and vim.fn.filereadable(config) == 0 then
            vim.api.nvim_err_writeln("No mcpservers.json found in " .. config)
            return
        end

        require("mcphub").setup({
            -- Required options
            port = 3000,
            config = final_config,

            -- Optional options
            on_ready = function(hub)
                -- Called when hub is ready
            end,
            on_error = function(err)
                -- Called on errors
            end,
            log = {
                level = vim.log.levels.WARN,
                to_file = false,
                file_path = nil,
                prefix = "MCPHub"
            },
        })
    end,
}
