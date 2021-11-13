## dc-sample-rest-api
This is a template of a REST API application built with ObjectScript in InterSystems IRIS.
It contains the example of unauthenticated and authenticated access to the persistent data via REST API.
It demoes the creation of users, roles and how to grant the access.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation with ZPM

zpm:USER>install dc-sample-rest

## Installation for development with Docker

Create your repository from template.

Clone/git pull the repo into any local directory e.g. like it is shown below (here I show all the examples related to this repository, but I assume you have your own derived from the template):

```
$ git clone git@github.com:intersystems-community/secured-rest-api.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d --build
```
## How to Work With it

This template creates two REST API web Apps: unsecured /crudall with access from any user.
 and /crud REST web-application with basic authentication. 
 The REST API spec is the same and  implements 4 types of communication: GET, POST, PUT and DELETE aka CRUD operations.
These interface works with a sample persistent class dc.sample.rest.Person.

Open http://localhost:52773/swagger-ui/index.html to test the REST API

The template also creates:
 * 10 random records in dc.sample.rest.Person
 * two roles: Reader with right to read records from dc.sample.rest.Person and Writer with right to add and alter.
 * two users: Bill with Reader role and John with Writer role.


## Testing unsecure access

UnknownUser that represents the unauthenticated access has the Reader role. And we can test unsecure access with /crudall web app.

### Testin GET requests

Open http://localhost:52773/crudall/persons/all to see the records from Person class in JSON, like this:

We see them because /crudall doesn't demand authentication according to [this line in ZPM module]()



# Testing basic authentication





To test GET you need to have some data. You can create it with POST request (see below), or you can create some fake testing data. to do that open IRIS terminal or web terminal on /localhost:52773/terminal/  and call:

```
USER>do ##class(Sample.Person).AddTestData(10)
```
This will create 10 random records in Sample.Person class.


You can get swagger Open API 2.0 documentation on:
```
localhost:yourport/_spec
```

This REST API exposes two GET requests: all the data and one record.
To get all the data in JSON call:

```
localhost:52773/crud/persons/all
```

To request the data for a particular record provide the id in GET request like 'localhost:52773/crud/persons/id' . E.g.:

```
localhost:52773/crud/persons/1
```

This will return JSON data for the person with ID=1, something like that:

```
{"Name":"Elon Mask","Title":"CEO","Company":"Tesla","Phone":"123-123-1233","DOB":"1982-01-19"}
```

# Testing POST request

Create a POST request e.g. in Postman with raw data in JSON. e.g.

```
{"Name":"Elon Mask","Title":"CEO","Company":"Tesla","Phone":"123-123-1233","DOB":"1982-01-19"}
```

Adjust the authorisation if needed - it is basic for container with default login and password for IRIR Community edition container

and send the POST request to localhost:52773/crud/persons/

This will create a record in Sample.Person class of IRIS.

# Testing PUT request

PUT request could be used to update the records. This needs to send the similar JSON as in POST request above supplying the id of the updated record in URL.
E.g. we want to change the record with id=5. Prepare in Postman the JSON in raw like following:

```
{"Name":"Jeff Besos","Title":"CEO","Company":"Amazon","Phone":"123-123-1233","DOB":"1982-01-19"}
```

and send the put request to:
```
localhost:52773/crud/persons/5
```

# Testing DELETE request

For delete request this REST API expects only the id of the record to delete. E.g. if the id=5 the following DELETE call will delete the record:

```
localhost:52773/crud/persons/5
```

## How to start coding
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.
Open /src/cls/PackageSample/ObjectScript.cls class and try to make changes - it will be compiled in running IRIS docker container.

Feel free to delete PackageSample folder and place your ObjectScript classes in a form
/src/cls/Package/Classname.cls

The script in Installer.cls will import everything you place under /src/cls into IRIS.

## What's insde the repo

# Dockerfile

The simplest dockerfile to start IRIS and load ObjectScript from /src/cls folder
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.

# .vscode/settings.json

Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript))

# .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript
