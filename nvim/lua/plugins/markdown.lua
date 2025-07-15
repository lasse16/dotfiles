return {
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            -- file and directory options
            dir_path = "images",
            file_name = "%Y-%m-%d-%H-%M-%S",
            relative_to_current_file = false,

            -- template options
            template = "$FILE_PATH",
            relative_template_path = true,
            use_cursor_in_template = true,
            insert_mode_after_paste = true,

            -- prompt options
            prompt_for_file_name = true,
            show_dir_path_in_prompt = false,

            -- image options
            copy_images = true,
            download_images = true,

            -- drag and drop options
            drag_and_drop = {
                enabled = true,
                insert_mode = false,
            },

            -- filetype specific options
            filetypes = {
                markdown = {
                    url_encode_path = true,
                    template = "![$CURSOR]($FILE_PATH)",
                    download_images = true,
                },
                quarto = {
                    dir_path = "images",
                    url_encode_path = true,
                    template = "![$CURSOR]($FILE_PATH)",
                    download_images = true,
                },
            },
        },
    },
}
