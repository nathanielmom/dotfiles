-- Function to read .env file from ~/.config/nvim/ and set environment variables
function load_env_file(filepath)
    local env_file = io.open(filepath, "r")
    if not env_file then return end

    for line in env_file:lines() do
        for key, value in string.gmatch(line, "(%w+)=([%w%p]+)") do
            vim.env[key] = value
        end
    end

    env_file:close()
end

load_env_file(vim.fn.expand("~/.config/nvim/.env"))


