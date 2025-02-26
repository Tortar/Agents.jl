#=
This file implements the "agent-space interaction API" for `nothing`, ie
no space type. In contrast to all other extensions, here we have to extend
the `remove_agent!` and `add_agent!` functions directly,
otherwise they will try to add `nothing` to the agent position.
=#

function add_agent_to_space!(::A, ::ABM{Nothing,A}) where {A<:AbstractAgent}
    nothing
end

function add_agent!(agent::A, model::ABM{Nothing,A}) where {A<:AbstractAgent}
    add_agent_pos!(agent, model)
end

# We need to extend this one, because otherwise there is a `pos` that
# is attempted to be given to the agent creation...
function add_agent!(A::Type{<:AbstractAgent}, model::ABM{Nothing}, properties::Vararg{Any, N}; kwproperties...) where {N}
    id = nextid(model)
    if isempty(kwproperties)
        newagent = A(id, properties...)
    else
        newagent = A(; id = id, kwproperties...)
    end
    add_agent_pos!(newagent, model)
end

nearby_ids(position, model::ABM{Nothing}, r = 1) = allids(model)
remove_agent_from_space!(agent, model::ABM{Nothing}) = nothing
add_agent_to_space!(agent, model::ABM{Nothing}) = nothing

