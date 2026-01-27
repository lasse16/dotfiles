M = {}

---Apply a function to each element of a list and return the updated list
---@generic T
---@generic V
---@param list T[]
---@param func fun(elem: T): V
---@return V[]
M.map = function(list, func)
    local result = {}
    for _, elem in ipairs(list) do
        table.insert(result, func(elem))
    end
    return result
end

return M
