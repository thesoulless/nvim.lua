return {
    "navarasu/onedark.nvim",
    -- cmd = require('onedard').load(),
    config = function()
        require('onedark').setup({
            style = 'warmer',
            transparent = false,
        })

        require('onedark').load()
    end
}
