return {
    "kcl-lang/kcl.nvim",
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
