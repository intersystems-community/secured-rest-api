Class esh.sample.rest.Person Extends (%Persistent, %JSON.Adaptor, %Populate)
{

Property Name As %VarString;

Property Title As %String;

Property Company As %String;

Property Phone As %VarString;

Property DOB As %Date(MAXVAL = "$piece($horolog, "","", 1)");

/// Index for property DOB
Index DOBIndex On DOB;

ClassMethod AddTestData(amount As %Integer = 10)
{
    d ..Populate(amount)
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Title</Value>
</Value>
<Value name="4">
<Value>Company</Value>
</Value>
<Value name="5">
<Value>Phone</Value>
</Value>
<Value name="6">
<Value>DOB</Value>
</Value>
</Data>
<DataLocation>^esh.sample.rest.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^esh.sample.rest.PersonD</IdLocation>
<IndexLocation>^esh.sample.rest.PersonI</IndexLocation>
<StreamLocation>^esh.sample.rest.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
