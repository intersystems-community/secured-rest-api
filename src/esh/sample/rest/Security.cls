/// Class to deploy roles and users
Class esh.sample.rest.Security
{

/// Create users
ClassMethod CreateUsers() As %Status
{
    Set sc = $$$OK
    set ns=$ZNSPACE
    zn "%SYS"
    try {

        if '##class(Security.Users).Exists("Bill") {
        //
            &sql(CREATE USER Bill IDENTIFY BY ChangeMe)
            if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,%msg)
        }
        if '##class(Security.Users).Exists("John") {
        &sql(CREATE USER John IDENTIFY BY ChangeMe)
        if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,%msg)
        }
    }
    catch e {
        set sc=e.AsStatus()
 	    do e.Log()
    }
    set $ZNSPACE=ns

    Return sc
}

/// Create Roles
ClassMethod CreateRoles() As %Status
{
    Set sc = $$$OK
    &sql(CREATE ROLE Writer)
    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,%msg)

    &sql(GRANT UPDATE,INSERT ON esh_sample_rest.Person TO writer)
    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,%msg)


    &sql(CREATE ROLE Reader)
    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,%msg)

    &sql(GRANT SELECT ON esh_sample_rest.Person TO Reader)
    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,%msg)

    Return sc
}

/// Grant
ClassMethod GrantRoles() As %Status
{
    Set sc = $$$OK
    // do something

    &sql(GRANT Reader To Bill)
    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,%msg)

    &sql(GRANT Reader To UnknownUser)
    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,%msg)


    &sql(GRANT Writer To John)
    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,%msg)


    Return sc
}

}
