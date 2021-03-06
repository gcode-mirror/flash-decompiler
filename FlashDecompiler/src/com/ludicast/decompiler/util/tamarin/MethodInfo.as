package com.ludicast.decompiler.util.tamarin
{
	import flash.utils.ByteArray;
	
	public class MethodInfo extends MemberInfo
	{


		public var flags:int
		public var debugName:*;
		public var paramTypes:*;
		public var optionalValues:*;
		public var returnType:*;
		public var local_count:int
		public var max_scope:int
		public var max_stack:int
		public var code_length:uint
		public var code:ByteArray
		public var activation:Traits
		public var anon:Boolean

		public function toString():String
		{
			return format()
		}
		
		public function format():String
		{
			var s:String = ""
			if (flags & Constants.NATIVE)
				s = "native "

			return s + Constants.traitKinds[kind] + " " + name + "(" + paramTypes + "):" + returnType + "\t/* disp_id " + id + "*/"
		}

		public function dump(abc:Abc, indent:String, attr:String=""):*  //Kidwell added *
		{
			Constants.print("")

			if (metadata) {
				for each (var md:* in metadata)  //Kidwell added *
					Constants.print(indent+md)
			}

			Constants.print(indent+attr+format())
			if (code)
			{
				Constants.print(indent+"{")
				var oldindent:* = indent  //Kidwell added *
				indent += Constants.TAB
				if (flags & Constants.NEED_ACTIVATION) {
					Constants.print(indent+"activation {")
					activation.dump(abc, indent+Constants.TAB, "")
					Constants.print(indent+"}")
				}
				Constants.print(indent+"// local_count="+local_count+
					  " max_scope=" + max_scope +
					  " max_stack=" + max_stack +
					  " code_len=" + code.length) 
				code.position = 0
				var labels:LabelInfo = new LabelInfo()
				while (code.bytesAvailable > 0)
				{
					var start:int = code.position
					var s:* = indent + start  //Kidwell added *
					while (s.length < 12) s += ' ';
					var opcode:* = code.readUnsignedByte()  //Kidwell added *

					if (opcode == Constants.OP_label || ((code.position-1) in labels)) {
						Constants.print(indent)
						Constants.print(indent + labels.labelFor(code.position-1) + ": ")
					}

					s += Constants.opNames[opcode]
					s += Constants.opNames[opcode].length < 8 ? "\t\t" : "\t"
						
					switch(opcode)
					{
						case Constants.OP_debugfile:
						case Constants.OP_pushstring:
							s += '"' + abc.strings[readU32()].replace(/\n/g,"\\n").replace(/\t/g,"\\t") + '"'
							break
						case Constants.OP_pushnamespace:
							s += abc.namespaces[readU32()]
							break
						case Constants.OP_pushint:
							var i:int = abc.ints[readU32()]
							s += i + "\t// 0x" + i.toString(16)
							break
						case Constants.OP_pushuint:
							var u:uint = abc.uints[readU32()]
							s += u + "\t// 0x" + u.toString(16)
							break;
						case Constants.OP_pushdouble:
							s += abc.doubles[readU32()]
							break;
						case Constants.OP_getsuper: 
						case Constants.OP_setsuper: 
						case Constants.OP_getproperty: 
						case Constants.OP_initproperty: 
						case Constants.OP_setproperty: 
						case Constants.OP_getlex: 
						case Constants.OP_findpropstrict: 
						case Constants.OP_findproperty:
						case Constants.OP_finddef:
						case Constants.OP_deleteproperty: 
						case Constants.OP_istype: 
						case Constants.OP_coerce: 
						case Constants.OP_astype: 
						case Constants.OP_getdescendants:
							s += abc.names[readU32()]
							break;
						case Constants.OP_constructprop:
						case Constants.OP_callproperty:
						case Constants.OP_callproplex:
						case Constants.OP_callsuper:
						case Constants.OP_callsupervoid:
						case Constants.OP_callpropvoid:
							s += abc.names[readU32()]
							s += " (" + readU32() + ")"
							break;
						case Constants.OP_newfunction: {
							var method_id:* = readU32()  //Kidwell added *
							s += abc.methods[method_id]
							abc.methods[method_id].anon = true
							break;
						}
						case Constants.OP_callstatic:
							s += abc.methods[readU32()]
							s += " (" + readU32() + ")"
							break;
						case Constants.OP_newclass: 
							s += abc.instances[readU32()]
							break;
						case Constants.OP_lookupswitch:
							var pos:* = code.position-1;  //Kidwell added *
							var target:* = pos + readS24()  //Kidwell added *
							var maxindex:* = readU32() //Kidwell added *
							s += "default:" + labels.labelFor(target) // target + "("+(target-pos)+")"
							s += " maxcase:" + maxindex
							for (var cnt:int=0; cnt <= maxindex; cnt++) {  //Kidwell changed to cnt
								target = pos + readS24();
								s += " " + labels.labelFor(target) // target + "("+(target-pos)+")"
							}
							break;
						case Constants.OP_jump:
						case Constants.OP_iftrue:		case Constants.OP_iffalse:
						case Constants.OP_ifeq:		case Constants.OP_ifne:
						case Constants.OP_ifge:		case Constants.OP_ifnge:
						case Constants.OP_ifgt:		case Constants.OP_ifngt:
						case Constants.OP_ifle:		case Constants.OP_ifnle:
						case Constants.OP_iflt:		case Constants.OP_ifnlt:
						case Constants.OP_ifstricteq:	case Constants.OP_ifstrictne:
							var offset2:* = readS24()  //Kidwell added *
							var target2:* = code.position+offset2  //Kidwell added *
							//s += target + " ("+offset+")"
							s += labels.labelFor(target2)
							if (!((code.position) in labels))
								s += "\n"
							break;
						case Constants.OP_inclocal:
						case Constants.OP_declocal:
						case Constants.OP_inclocal_i:
						case Constants.OP_declocal_i:
						case Constants.OP_getlocal:
						case Constants.OP_kill:
						case Constants.OP_setlocal:
						case Constants.OP_debugline:
						case Constants.OP_getglobalslot:
						case Constants.OP_getslot:
						case Constants.OP_setglobalslot:
						case Constants.OP_setslot:
						case Constants.OP_pushshort:
						case Constants.OP_newcatch:
							s += readU32()
							break
						case Constants.OP_debug:
							s += code.readUnsignedByte() 
							s += " " + readU32()
							s += " " + code.readUnsignedByte()
							s += " " + readU32()
							break;
						case Constants.OP_newobject:
							s += "{" + readU32() + "}"
							break;
						case Constants.OP_newarray:
							s += "[" + readU32() + "]"
							break;
						case Constants.OP_call:
						case Constants.OP_construct:
						case Constants.OP_constructsuper:
							s += "(" + readU32() + ")"
							break;
						case Constants.OP_pushbyte:
						case Constants.OP_getscopeobject:
							s += code.readByte()
							break;
						case Constants.OP_hasnext2:
							s += readU32() + " " + readU32()
						default:
							/*if (opNames[opcode] == ("0x"+opcode.toString(16).toUpperCase()))
								s += " UNKNOWN OPCODE"*/
							break
					}
					var size:int = code.position - start
					Constants.totalSize += size
					Constants.opSizes[opcode] = int(Constants.opSizes[opcode]) + size
					Constants.print(s)
				}
				Constants.print(oldindent+"}\n")
			}
		}
		
		public function readU32():int
		{
			var result:int = code.readUnsignedByte();
			if (!(result & 0x00000080))
				return result;
			result = result & 0x0000007f | code.readUnsignedByte()<<7;
			if (!(result & 0x00004000))
				return result;
			result = result & 0x00003fff | code.readUnsignedByte()<<14;
			if (!(result & 0x00200000))
				return result;
			result = result & 0x001fffff | code.readUnsignedByte()<<21;
			if (!(result & 0x10000000))
				return result;
			return   result & 0x0fffffff | code.readUnsignedByte()<<28;
		}
		
		public function readS24():int
		{
			var b:int = code.readUnsignedByte()
			b |= code.readUnsignedByte()<<8
			b |= code.readByte()<<16
			return b
		}
	}
}

