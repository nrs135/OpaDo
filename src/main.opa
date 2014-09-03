function with_request(f){
  f(ThreadContext.get({current}).request ? error("no request"))
}

resources = @static_resource_directory("resources")

urls = parser {
    //Rule.debug_parse_string((function(s){Log.notice("URL", s)}))
    //Rule.fail : error("Error")
    | r={Server.resource_map(resources)} .* : r
    | special=AuthorAccess.special_uris2 -> special
    | "/todos?" result={Todo.resource} : with_request(result)
    | "/connect?" data=(.*)            : User.connect(Text.to_string(data)) 
    | "/user"  result={User.resource}  : with_request(result)
    | "/login" result={User.resource}  : with_request(result)
    | "/admin" result={Admin.resource} : with_request(result)
    | (.*)     result={Todo.resource}  : with_request(result)
    }

Server.start(Server.http,
        [//{resources:@static_resource_directory("resources")},
         {register:{js:["/resources/js/google_analytics.js"]}},
         {custom:urls}]
)


