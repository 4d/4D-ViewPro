# VP Convert from 4D View


**VP Convert from 4D View** ( *4DViewDocument* : Blob ) : Object



|Parameter|Type| |Description|
|---|---|---|---|
|4DViewDocument| Blob|->|4D View document|
|Result| Object|<-|4D View Pro object

## Description

The `VP Convert from 4D View` command allows you to convert a legacy 4D View document into a 4D View Pro object.

>This command does not require that the legacy 4D View plug-in be installed in your environment.

In the *4DViewDocument* parameter, pass a BLOB variable or field containing the 4D View document to convert. The command returns a 4D View Pro object into which all the information originally stored within the 4D View document is converted to 4D View Pro attributes.

## Example  

You want to get a 4D View Pro object from a 4D View area stored in a BLOB:

```4d
C_OBJECT($vpObj)
$vpObj:=VP Convert from 4D View($pvblob)
```