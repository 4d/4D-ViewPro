//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $source : Variant; $options : Object)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If (vp_isReady($area; Current method name:C684))
			
			var $params:={}
			
			If ($nbParameters<3)
				$options:={}
			End if 
			
			Case of 
					
				: ((Value type:C1509($source)=Is object:K8:27) && (OB Instance of:C1731($source; 4D:C1709.DataClass)))

					$params.mode:="dataclass"
					
					var $info : Object:=$source.getInfo()
					
					$params.dataClassName:=$info.name
					$params.name:=String:C10($options.name)="" ? $params.dataClassName : $options.name
					
					var $attributes:=[]
					var $fields : Collection:=(Value type:C1509($options.fields)=Is collection:K8:32) ? $options.fields : Null:C1517
					var $attr : Object
					var $attrName : Text
					For each ($attrName; $source)
						$attr:=$source[$attrName]
						If ($attr.kind="storage")
							If (($fields=Null:C1517) || ($fields.includes($attr.name)))
								$attributes.push({name: $attr.name; type: String:C10($attr.type)})
							End if
						End if
					End for each

					$params.attributes:=$attributes

					var $relations:=[]
					For each ($attrName; $source)
						$attr:=$source[$attrName]
						If (($attr.kind="relatedEntity") || ($attr.kind="relatedEntities"))
							$relations.push({\
								name: $attr.name; \
								kind: $attr.kind; \
								relatedDataClass: String:C10($attr.relatedDataClass); \
								inverseName: String:C10($attr.inverseName)\
								})
						End if
					End for each
					If ($relations.length>0)
						$params.relations:=$relations
					End if

				: (Value type:C1509($source)=Is object:K8:27)

					$params.mode:="data"
					$params.name:=String:C10($options.name)
					If ($params.name="")
						err_THROW({code: 25})
						return
					End if
					$params.data:=$source

					If ($options.schema#Null:C1517)
						$params.schema:=OB Copy:C1225($options.schema)
					Else
						$params.schema:={type: "columnJson"}
					End if

				: (Value type:C1509($source)=Is collection:K8:32)
					
					$params.mode:="data"
					$params.name:=String:C10($options.name)
					If ($params.name="")
						err_THROW({code: 25})
						return 
					End if 
					$params.data:=$source
					
					If ($options.schema#Null:C1517)
						$params.schema:=OB Copy:C1225($options.schema)
					End if 
					
				: (Value type:C1509($source)=Is text:K8:3)
					
					If ($options.remote#Null:C1517)
						
						$params.mode:="custom"
						$params.name:=String:C10($options.name)="" ? $source : $options.name
						
						$params.remote:=OB Copy:C1225($options.remote)
						
						If ($options.schema#Null:C1517)
							$params.schema:=OB Copy:C1225($options.schema)
						End if 
						
					Else 
						
						$params.mode:="data"
						$params.name:=String:C10($options.name)
						If ($params.name="")
							err_THROW({code: 25})
							return 
						End if 
						$params.data:=$source
						
						If ($options.schema#Null:C1517)
							$params.schema:=OB Copy:C1225($options.schema)
						Else 
							err_THROW({code: 25})
							return 
						End if 
						
					End if 
					
				Else 
					
					err_THROW({code: 25})
					return 
					
			End case

			If ($options.primaryKey#Null:C1517)
				$params.primaryKey:=$options.primaryKey
			End if

			If ($options.relationships#Null:C1517)
				$params.relationships:=OB Copy:C1225($options.relationships)
			End if

			$params.options:=OB Copy:C1225($options)
			
			vp_runCommand($area; "add-data-source"; $params)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 
