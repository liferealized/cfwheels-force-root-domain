<cfcomponent mixin="controller" output="false">
    
  <cffunction name="init" access="public" output="false" returntype="any">
    <cfscript>
      this.version = "1.1.8";
    </cfscript>
    <cfreturn this />
  </cffunction>

  <cffunction name="forceRootDomain" access="public" output="false" returntype="void">
    <cfset filters(through="_forceRootDomain") />
  </cffunction>

  <!--- controller helpers --->

  <cffunction name="_forceRootDomain" access="public" output="false" returntype="void">
    <cfargument name="httpHost" type="string" required="false" default="#cgi.http_host#" />
    <cfscript>
      var loc = { args = {} };

      if (listLen(arguments.httpHost, ".") gt 2)
      {
        // get our key params
        for (loc.item in params)
          if (loc.item contains "key" or loc.item eq "action")
            loc.args[loc.item] = params[loc.item];

        while (listLen(arguments.httpHost, ".") gt 2)
          arguments.httpHost = listDeleteAt(arguments.httpHost, 1, ".");

        redirectTo(route=params.route, host=arguments.httpHost, onlyPath=false, statusCode=301, argumentCollection=loc.args);
      }
    </cfscript>
  </cffunction>


</cfcomponent>