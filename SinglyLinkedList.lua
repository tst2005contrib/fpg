local List = {}

List.__index = List

List.null = setmetatable({ head = false, tail = false, length = 0 }, List)

function List.cons(head, tail)
  return setmetatable({ head = head, tail = tail, length = tail.length + 1 }, List)
end

function List.getHead(tbl)
  return tbl.head
end

function List.getTail(tbl)
  return tbl.tail
end

function List.getLength(tbl)
  return tbl.length
end

local function setValue(val, tbl, idx)
  tbl[idx] = val
  return tbl, idx + 1
end

-- Deepest value first, top value last.
function List.take(instance, count)
  function loop(tbl, count)
    local head = tbl:getHead()
  
    if not head or count == 0 then
       return {}, 1
    else
      return setValue(head, loop(tbl:getTail(), count - 1))
    end
  end
  
  return loop(instance, count or math.huge), nil -- suppressing second argument
end

function List.takeWhile(instance, predicate)
  function loop(tbl)
    local head = tbl:getHead()
  
    if not head or not predicate(head) then
       return {}, 1
    else
      return setValue(head, loop(tbl:getTail()))
    end
  end
  
  return loop(instance), nil -- suppressing second argument
end


function List.__tostring(instance)
  if instance == List.null then return "null" end
  return table.concat(instance:take())
end

return List
