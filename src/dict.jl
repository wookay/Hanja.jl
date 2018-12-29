using BSON

function 사전가져오기(path::String=normpath(@__DIR__, "..", "data", "dict.bson"))
    BSON.@load path dict
    return dict
end
