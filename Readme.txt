genpackets - generates source code for packet classes, which can serialize/deserialize themselves from/to binary/xml data.
Run as:
./genpackets <packets_file>

Packets file contains one or multiple packets descriptors.
Lines which are empty, start with # or // are ignored.
Opening curly brace { must be on the same line as packet name and attributes.
Closing curly brace } must be on the separate line.

Packet example:
UserStateInfo 170 in {
    uint16 loginId
    float32 deposit 
    # Comment
    uint8 state 
    remaining ucs2lestring message
}


Packet description format
-------------------------

<name> <attributes> {
	<field>
	<field>
	...
}

<name> - packet name

<attributes> may be one or more of the following:
<number> - packet id
in - means generate deserialization code
out - means generate serialization code
xml - serialization/deserialization code is generated for xml data (if xml attribute is missing, code is generated for binary data)
data - class is not packet, but standalone object (uses slightly different method names for serialization/deserialization, otherwise it's the same as packet)

<field> format for binary packets:
<type> <name>
<name> - property in generated code will have this name

<field> format for xml packets:
[optional] [remaining] <type> <xmlName> <propertyName>
<xmlName> - serialization/deserialization code will use this name for writing/reading xml attributes
<propertyName> - property in generated code will have this name
optional - means that error will NOT be generated if this field is missing/can't be parsed when deserializing xml
remaining - means that field has length up to the end of packet. Only supported for ucs2lestring, asciistring and data types

<type> list for binary & xml packets:
uint8        
sint8        
uint16       
sint16       
uint32       
sint32       
uint64       
sint64       
float32      
float64      
bool         1 byte
char         1 byte
string       UTF-8 string
ucs2lestring Unicode string in UCS-2 little-endian format (2 bytes per character)
asciistring  ASCII string (1 byte per character)
data         binary data