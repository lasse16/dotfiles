return {
    "kcl-lang/kcl.nvim",
    {
        "cenk1cenk2/schema-companion.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        ft = "yaml",
    },
    {
        "cwrau/yaml-schema-detect.nvim",
        ---@module "yaml-schema-detect"
        ---@type YamlSchemaDetectOptions
        opts = { disable_keymap = true },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "yaml" },
    },
}
