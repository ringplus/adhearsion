# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
# -*- ruby -*-
require 'rubygems'
require 'active_support'

require File.join(File.dirname(__FILE__), 'packets.rb')

class AmiStreamParser

  BUFFER_SIZE = 8.kilobytes unless defined? BUFFER_SIZE

  CAPTURED_VARIABLES = {} unless defined? CAPTURED_VARIABLES
  CAPTURE_CALLBACKS  = {} unless defined? CAPTURE_CALLBACKS

  # line 69 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
 # %

  attr_accessor :ami_version
  def initialize
    
    @data = ""
    @current_pointer = 0
    
# line 25 "lib/adhearsion/voip/asterisk/new-ami/ami.rb"
class << self
	attr_accessor :_ami_protocol_parser_actions
	private :_ami_protocol_parser_actions, :_ami_protocol_parser_actions=
end
self._ami_protocol_parser_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 1, 4, 1, 5, 1, 6, 1, 
	9, 1, 10, 1, 11, 1, 12, 1, 
	13, 1, 14, 1, 15, 1, 16, 1, 
	17, 1, 18, 1, 21, 1, 24, 1, 
	26, 1, 27, 1, 28, 1, 29, 1, 
	30, 1, 31, 1, 32, 1, 33, 1, 
	35, 1, 36, 1, 37, 1, 38, 1, 
	39, 1, 42, 1, 43, 1, 44, 1, 
	45, 1, 46, 2, 2, 14, 2, 3, 
	4, 2, 4, 5, 2, 7, 34, 2, 
	8, 22, 2, 16, 17, 2, 19, 33, 
	2, 20, 33, 2, 24, 25, 2, 27, 
	40, 3, 27, 23, 41
]

class << self
	attr_accessor :_ami_protocol_parser_key_offsets
	private :_ami_protocol_parser_key_offsets, :_ami_protocol_parser_key_offsets=
end
self._ami_protocol_parser_key_offsets = [
	0, 0, 1, 2, 3, 4, 5, 6, 
	7, 8, 9, 10, 11, 12, 13, 14, 
	15, 16, 17, 18, 19, 20, 22, 25, 
	27, 30, 31, 34, 37, 38, 39, 40, 
	42, 44, 45, 46, 47, 48, 49, 50, 
	51, 52, 53, 54, 55, 56, 57, 58, 
	59, 60, 61, 62, 63, 64, 66, 69, 
	71, 74, 75, 78, 81, 83, 85, 87, 
	88, 90, 91, 93, 95, 97, 99, 101, 
	103, 105, 107, 108, 116, 124, 126, 128, 
	130, 132, 133, 134, 136, 138, 140, 142, 
	144, 146, 148, 149, 151, 152, 154, 155, 
	156, 158, 159, 160, 161, 162, 163, 164, 
	165, 166, 167, 168, 170, 172, 174, 175, 
	176, 178, 180, 182, 184, 186, 188, 189, 
	190, 191, 192, 194, 195, 197, 212, 213, 
	228, 243, 258, 275, 276, 278, 293, 308, 
	325, 341, 357, 374, 375, 377, 379, 381, 
	383, 385, 387, 389, 391, 393, 395, 397, 
	399, 401, 403, 405, 407, 408, 409, 411, 
	427, 443, 459, 476, 477, 479, 495, 511, 
	527, 544, 545, 547, 564, 581, 598, 615, 
	632, 649, 666, 683, 700, 717, 734, 751, 
	768, 785, 801, 816, 831, 848, 849, 851, 
	866, 881, 898, 914, 930, 947, 963, 980, 
	996, 1012, 1029, 1046, 1062, 1078, 1095, 1111, 
	1112, 1113, 1113, 1119, 1120, 1121, 1123, 1125, 
	1126, 1126, 1141, 1143, 1159, 1175
]

class << self
	attr_accessor :_ami_protocol_parser_trans_keys
	private :_ami_protocol_parser_trans_keys, :_ami_protocol_parser_trans_keys=
end
self._ami_protocol_parser_trans_keys = [
	116, 101, 114, 105, 115, 107, 32, 67, 
	97, 108, 108, 32, 77, 97, 110, 97, 
	103, 101, 114, 47, 48, 57, 46, 48, 
	57, 48, 57, 13, 48, 57, 10, 13, 
	48, 57, 46, 48, 57, 13, 13, 13, 
	10, 13, 10, 13, 116, 101, 114, 105, 
	115, 107, 32, 67, 97, 108, 108, 32, 
	77, 97, 110, 97, 103, 101, 114, 47, 
	48, 57, 46, 48, 57, 48, 57, 13, 
	48, 57, 10, 13, 48, 57, 46, 48, 
	57, 69, 101, 78, 110, 84, 116, 58, 
	13, 32, 13, 10, 13, 13, 32, 83, 
	115, 80, 112, 79, 111, 78, 110, 83, 
	115, 69, 101, 58, 32, 69, 70, 80, 
	83, 101, 112, 115, 32, 69, 70, 80, 
	83, 101, 112, 115, 82, 114, 82, 114, 
	79, 111, 82, 114, 13, 10, 77, 109, 
	69, 101, 83, 115, 83, 115, 65, 97, 
	71, 103, 69, 101, 58, 13, 32, 13, 
	10, 13, 13, 10, 13, 32, 111, 108, 
	108, 111, 119, 115, 13, 10, 13, 10, 
	79, 111, 78, 110, 71, 103, 13, 10, 
	85, 117, 67, 99, 67, 99, 69, 101, 
	83, 115, 83, 115, 13, 10, 13, 13, 
	10, 13, 13, 10, 13, 13, 32, 47, 
	48, 57, 58, 64, 65, 90, 91, 96, 
	97, 122, 123, 126, 10, 58, 32, 47, 
	48, 57, 59, 64, 65, 90, 91, 96, 
	97, 122, 123, 126, 58, 32, 47, 48, 
	57, 59, 64, 65, 90, 91, 96, 97, 
	122, 123, 126, 58, 32, 47, 48, 57, 
	59, 64, 65, 90, 91, 96, 97, 122, 
	123, 126, 13, 32, 58, 33, 47, 48, 
	57, 59, 64, 65, 90, 91, 96, 97, 
	122, 123, 126, 13, 10, 13, 13, 32, 
	47, 48, 57, 58, 64, 65, 90, 91, 
	96, 97, 122, 123, 126, 58, 32, 47, 
	48, 57, 59, 64, 65, 90, 91, 96, 
	97, 122, 123, 126, 13, 32, 58, 33, 
	47, 48, 57, 59, 64, 65, 90, 91, 
	96, 97, 122, 123, 126, 13, 58, 32, 
	47, 48, 57, 59, 64, 65, 90, 91, 
	96, 97, 122, 123, 126, 13, 58, 32, 
	47, 48, 57, 59, 64, 65, 90, 91, 
	96, 97, 122, 123, 126, 13, 32, 58, 
	33, 47, 48, 57, 59, 64, 65, 90, 
	91, 96, 97, 122, 123, 126, 13, 10, 
	13, 13, 45, 13, 45, 13, 69, 13, 
	78, 13, 68, 13, 32, 13, 67, 13, 
	79, 13, 77, 13, 77, 13, 65, 13, 
	78, 13, 68, 13, 45, 13, 45, 13, 
	10, 10, 13, 13, 58, 32, 47, 48, 
	57, 59, 64, 65, 90, 91, 96, 97, 
	122, 123, 126, 13, 58, 32, 47, 48, 
	57, 59, 64, 65, 90, 91, 96, 97, 
	122, 123, 126, 13, 58, 32, 47, 48, 
	57, 59, 64, 65, 90, 91, 96, 97, 
	122, 123, 126, 13, 32, 58, 33, 47, 
	48, 57, 59, 64, 65, 90, 91, 96, 
	97, 122, 123, 126, 13, 10, 13, 13, 
	58, 32, 47, 48, 57, 59, 64, 65, 
	90, 91, 96, 97, 122, 123, 126, 13, 
	58, 32, 47, 48, 57, 59, 64, 65, 
	90, 91, 96, 97, 122, 123, 126, 13, 
	58, 32, 47, 48, 57, 59, 64, 65, 
	90, 91, 96, 97, 122, 123, 126, 13, 
	32, 58, 33, 47, 48, 57, 59, 64, 
	65, 90, 91, 96, 97, 122, 123, 126, 
	13, 10, 13, 13, 45, 58, 32, 47, 
	48, 57, 59, 64, 65, 90, 91, 96, 
	97, 122, 123, 126, 13, 58, 69, 32, 
	47, 48, 57, 59, 64, 65, 90, 91, 
	96, 97, 122, 123, 126, 13, 58, 78, 
	32, 47, 48, 57, 59, 64, 65, 90, 
	91, 96, 97, 122, 123, 126, 13, 58, 
	68, 32, 47, 48, 57, 59, 64, 65, 
	90, 91, 96, 97, 122, 123, 126, 13, 
	32, 58, 33, 47, 48, 57, 59, 64, 
	65, 90, 91, 96, 97, 122, 123, 126, 
	13, 58, 67, 32, 47, 48, 57, 59, 
	64, 65, 90, 91, 96, 97, 122, 123, 
	126, 13, 58, 79, 32, 47, 48, 57, 
	59, 64, 65, 90, 91, 96, 97, 122, 
	123, 126, 13, 58, 77, 32, 47, 48, 
	57, 59, 64, 65, 90, 91, 96, 97, 
	122, 123, 126, 13, 58, 77, 32, 47, 
	48, 57, 59, 64, 65, 90, 91, 96, 
	97, 122, 123, 126, 13, 58, 65, 32, 
	47, 48, 57, 59, 64, 66, 90, 91, 
	96, 97, 122, 123, 126, 13, 58, 78, 
	32, 47, 48, 57, 59, 64, 65, 90, 
	91, 96, 97, 122, 123, 126, 13, 58, 
	68, 32, 47, 48, 57, 59, 64, 65, 
	90, 91, 96, 97, 122, 123, 126, 13, 
	45, 58, 32, 47, 48, 57, 59, 64, 
	65, 90, 91, 96, 97, 122, 123, 126, 
	13, 45, 58, 32, 47, 48, 57, 59, 
	64, 65, 90, 91, 96, 97, 122, 123, 
	126, 13, 58, 32, 47, 48, 57, 59, 
	64, 65, 90, 91, 96, 97, 122, 123, 
	126, 58, 32, 47, 48, 57, 59, 64, 
	65, 90, 91, 96, 97, 122, 123, 126, 
	58, 32, 47, 48, 57, 59, 64, 65, 
	90, 91, 96, 97, 122, 123, 126, 13, 
	32, 58, 33, 47, 48, 57, 59, 64, 
	65, 90, 91, 96, 97, 122, 123, 126, 
	13, 10, 13, 58, 32, 47, 48, 57, 
	59, 64, 65, 90, 91, 96, 97, 122, 
	123, 126, 58, 32, 47, 48, 57, 59, 
	64, 65, 90, 91, 96, 97, 122, 123, 
	126, 13, 32, 58, 33, 47, 48, 57, 
	59, 64, 65, 90, 91, 96, 97, 122, 
	123, 126, 13, 58, 32, 47, 48, 57, 
	59, 64, 65, 90, 91, 96, 97, 122, 
	123, 126, 13, 58, 32, 47, 48, 57, 
	59, 64, 65, 90, 91, 96, 97, 122, 
	123, 126, 13, 32, 58, 33, 47, 48, 
	57, 59, 64, 65, 90, 91, 96, 97, 
	122, 123, 126, 13, 58, 32, 47, 48, 
	57, 59, 64, 65, 90, 91, 96, 97, 
	122, 123, 126, 13, 32, 58, 33, 47, 
	48, 57, 59, 64, 65, 90, 91, 96, 
	97, 122, 123, 126, 13, 58, 32, 47, 
	48, 57, 59, 64, 65, 90, 91, 96, 
	97, 122, 123, 126, 13, 58, 32, 47, 
	48, 57, 59, 64, 65, 90, 91, 96, 
	97, 122, 123, 126, 13, 32, 58, 33, 
	47, 48, 57, 59, 64, 65, 90, 91, 
	96, 97, 122, 123, 126, 13, 32, 58, 
	33, 47, 48, 57, 59, 64, 65, 90, 
	91, 96, 97, 122, 123, 126, 13, 58, 
	32, 47, 48, 57, 59, 64, 65, 90, 
	91, 96, 97, 122, 123, 126, 13, 58, 
	32, 47, 48, 57, 59, 64, 65, 90, 
	91, 96, 97, 122, 123, 126, 13, 32, 
	58, 33, 47, 48, 57, 59, 64, 65, 
	90, 91, 96, 97, 122, 123, 126, 13, 
	58, 32, 47, 48, 57, 59, 64, 65, 
	90, 91, 96, 97, 122, 123, 126, 65, 
	115, 13, 65, 69, 82, 101, 114, 10, 
	115, 86, 118, 69, 101, 13, 13, 32, 
	47, 48, 57, 58, 64, 65, 90, 91, 
	96, 97, 122, 123, 126, 13, 45, 13, 
	45, 32, 47, 48, 57, 58, 64, 65, 
	90, 91, 96, 97, 122, 123, 126, 13, 
	45, 32, 47, 48, 57, 58, 64, 65, 
	90, 91, 96, 97, 122, 123, 126, 32, 
	47, 48, 57, 58, 64, 65, 90, 91, 
	96, 97, 122, 123, 126, 0
]

class << self
	attr_accessor :_ami_protocol_parser_single_lengths
	private :_ami_protocol_parser_single_lengths, :_ami_protocol_parser_single_lengths=
end
self._ami_protocol_parser_single_lengths = [
	0, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 0, 1, 0, 
	1, 1, 1, 1, 1, 1, 1, 2, 
	2, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 0, 1, 0, 
	1, 1, 1, 1, 2, 2, 2, 1, 
	2, 1, 2, 2, 2, 2, 2, 2, 
	2, 2, 1, 8, 8, 2, 2, 2, 
	2, 1, 1, 2, 2, 2, 2, 2, 
	2, 2, 1, 2, 1, 2, 1, 1, 
	2, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 2, 2, 2, 1, 1, 
	2, 2, 2, 2, 2, 2, 1, 1, 
	1, 1, 2, 1, 2, 1, 1, 1, 
	1, 1, 3, 1, 2, 1, 1, 3, 
	2, 2, 3, 1, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 1, 1, 2, 2, 
	2, 2, 3, 1, 2, 2, 2, 2, 
	3, 1, 2, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 2, 1, 1, 3, 1, 2, 1, 
	1, 3, 2, 2, 3, 2, 3, 2, 
	2, 3, 3, 2, 2, 3, 2, 1, 
	1, 0, 6, 1, 1, 2, 2, 1, 
	0, 1, 2, 2, 2, 0
]

class << self
	attr_accessor :_ami_protocol_parser_range_lengths
	private :_ami_protocol_parser_range_lengths, :_ami_protocol_parser_range_lengths=
end
self._ami_protocol_parser_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 0, 1, 1, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 1, 1, 
	1, 0, 1, 1, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 7, 0, 7, 
	7, 7, 7, 0, 0, 7, 7, 7, 
	7, 7, 7, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 7, 
	7, 7, 7, 0, 0, 7, 7, 7, 
	7, 0, 0, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 0, 0, 7, 
	7, 7, 7, 7, 7, 7, 7, 7, 
	7, 7, 7, 7, 7, 7, 7, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 7, 0, 7, 7, 7
]

class << self
	attr_accessor :_ami_protocol_parser_index_offsets
	private :_ami_protocol_parser_index_offsets, :_ami_protocol_parser_index_offsets=
end
self._ami_protocol_parser_index_offsets = [
	0, 0, 2, 4, 6, 8, 10, 12, 
	14, 16, 18, 20, 22, 24, 26, 28, 
	30, 32, 34, 36, 38, 40, 42, 45, 
	47, 50, 52, 55, 58, 60, 62, 64, 
	67, 70, 72, 74, 76, 78, 80, 82, 
	84, 86, 88, 90, 92, 94, 96, 98, 
	100, 102, 104, 106, 108, 110, 112, 115, 
	117, 120, 122, 125, 128, 131, 134, 137, 
	139, 142, 144, 147, 150, 153, 156, 159, 
	162, 165, 168, 170, 179, 188, 191, 194, 
	197, 200, 202, 204, 207, 210, 213, 216, 
	219, 222, 225, 227, 230, 232, 235, 237, 
	239, 242, 244, 246, 248, 250, 252, 254, 
	256, 258, 260, 262, 265, 268, 271, 273, 
	275, 278, 281, 284, 287, 290, 293, 295, 
	297, 299, 301, 304, 306, 309, 318, 320, 
	329, 338, 347, 358, 360, 363, 372, 381, 
	392, 402, 412, 423, 425, 428, 431, 434, 
	437, 440, 443, 446, 449, 452, 455, 458, 
	461, 464, 467, 470, 473, 475, 477, 480, 
	490, 500, 510, 521, 523, 526, 536, 546, 
	556, 567, 569, 572, 583, 594, 605, 616, 
	627, 638, 649, 660, 671, 682, 693, 704, 
	715, 726, 736, 745, 754, 765, 767, 770, 
	779, 788, 799, 809, 819, 830, 840, 851, 
	861, 871, 882, 893, 903, 913, 924, 934, 
	936, 938, 939, 946, 948, 950, 953, 956, 
	958, 959, 968, 971, 981, 991
]

class << self
	attr_accessor :_ami_protocol_parser_trans_targs
	private :_ami_protocol_parser_trans_targs, :_ami_protocol_parser_trans_targs=
end
self._ami_protocol_parser_trans_targs = [
	2, 207, 3, 207, 4, 207, 5, 207, 
	6, 207, 7, 207, 8, 207, 9, 207, 
	10, 207, 11, 207, 12, 207, 13, 207, 
	14, 207, 15, 207, 16, 207, 17, 207, 
	18, 207, 19, 207, 20, 207, 21, 207, 
	22, 207, 23, 27, 207, 24, 207, 25, 
	26, 207, 207, 207, 25, 26, 207, 23, 
	27, 207, 32, 29, 31, 30, 31, 30, 
	209, 31, 30, 0, 31, 30, 34, 210, 
	35, 210, 36, 210, 37, 210, 38, 210, 
	39, 210, 40, 210, 41, 210, 42, 210, 
	43, 210, 44, 210, 45, 210, 46, 210, 
	47, 210, 48, 210, 49, 210, 50, 210, 
	51, 210, 52, 210, 53, 210, 54, 210, 
	55, 59, 210, 56, 210, 57, 58, 210, 
	210, 210, 57, 58, 210, 55, 59, 210, 
	61, 61, 210, 62, 62, 210, 63, 63, 
	210, 64, 210, 66, 67, 65, 66, 65, 
	210, 66, 65, 66, 67, 65, 69, 69, 
	210, 70, 70, 210, 71, 71, 210, 72, 
	72, 210, 73, 73, 210, 74, 74, 210, 
	75, 210, 76, 77, 97, 107, 112, 77, 
	107, 112, 210, 76, 77, 97, 107, 112, 
	77, 107, 112, 210, 78, 78, 210, 79, 
	79, 210, 80, 80, 210, 81, 81, 210, 
	82, 210, 83, 210, 84, 84, 210, 85, 
	85, 210, 86, 86, 210, 87, 87, 210, 
	88, 88, 210, 89, 89, 210, 90, 90, 
	210, 91, 210, 93, 96, 92, 93, 92, 
	94, 93, 92, 95, 210, 210, 210, 93, 
	96, 92, 98, 210, 99, 210, 100, 210, 
	101, 210, 102, 210, 103, 210, 104, 210, 
	105, 210, 106, 210, 210, 210, 108, 108, 
	210, 109, 109, 210, 110, 110, 210, 111, 
	210, 210, 210, 113, 113, 210, 114, 114, 
	210, 115, 115, 210, 116, 116, 210, 117, 
	117, 210, 118, 118, 210, 119, 210, 210, 
	210, 122, 121, 122, 121, 123, 122, 121, 
	124, 121, 215, 122, 121, 126, 127, 134, 
	127, 134, 127, 134, 127, 0, 216, 0, 
	130, 128, 129, 128, 129, 128, 129, 128, 
	0, 130, 128, 129, 128, 129, 128, 129, 
	128, 0, 130, 128, 129, 128, 129, 128, 
	129, 128, 0, 132, 135, 138, 136, 137, 
	136, 137, 136, 137, 136, 131, 132, 131, 
	133, 132, 131, 126, 127, 134, 127, 134, 
	127, 134, 127, 0, 130, 128, 129, 128, 
	129, 128, 129, 128, 0, 132, 135, 138, 
	136, 137, 136, 137, 136, 137, 136, 131, 
	132, 138, 136, 137, 136, 137, 136, 137, 
	136, 131, 132, 138, 136, 137, 136, 137, 
	136, 137, 136, 131, 132, 135, 138, 136, 
	137, 136, 137, 136, 137, 136, 131, 140, 
	139, 141, 140, 139, 140, 142, 139, 140, 
	143, 139, 140, 144, 139, 140, 145, 139, 
	140, 146, 139, 140, 147, 139, 140, 148, 
	139, 140, 149, 139, 140, 150, 139, 140, 
	151, 139, 140, 152, 139, 140, 153, 139, 
	140, 154, 139, 140, 155, 139, 140, 156, 
	139, 157, 217, 217, 217, 218, 140, 139, 
	140, 162, 160, 161, 160, 161, 160, 161, 
	160, 139, 140, 162, 160, 161, 160, 161, 
	160, 161, 160, 139, 140, 162, 160, 161, 
	160, 161, 160, 161, 160, 139, 164, 202, 
	205, 203, 204, 203, 204, 203, 204, 203, 
	163, 164, 163, 219, 164, 163, 140, 168, 
	166, 167, 166, 167, 166, 167, 166, 139, 
	140, 168, 166, 167, 166, 167, 166, 167, 
	166, 139, 140, 168, 166, 167, 166, 167, 
	166, 167, 166, 139, 170, 198, 201, 199, 
	200, 199, 200, 199, 200, 199, 169, 170, 
	169, 220, 170, 169, 140, 172, 168, 166, 
	167, 166, 167, 166, 167, 166, 139, 140, 
	168, 173, 166, 167, 166, 167, 166, 167, 
	166, 139, 140, 168, 174, 166, 167, 166, 
	167, 166, 167, 166, 139, 140, 168, 175, 
	166, 167, 166, 167, 166, 167, 166, 139, 
	140, 176, 168, 166, 167, 166, 167, 166, 
	167, 166, 139, 140, 168, 177, 166, 167, 
	166, 167, 166, 167, 166, 139, 140, 168, 
	178, 166, 167, 166, 167, 166, 167, 166, 
	139, 140, 168, 179, 166, 167, 166, 167, 
	166, 167, 166, 139, 140, 168, 180, 166, 
	167, 166, 167, 166, 167, 166, 139, 140, 
	168, 181, 166, 167, 166, 167, 166, 167, 
	166, 139, 140, 168, 182, 166, 167, 166, 
	167, 166, 167, 166, 139, 140, 168, 183, 
	166, 167, 166, 167, 166, 167, 166, 139, 
	140, 184, 168, 166, 167, 166, 167, 166, 
	167, 166, 139, 140, 185, 168, 166, 167, 
	166, 167, 166, 167, 166, 139, 157, 188, 
	186, 187, 186, 187, 186, 187, 186, 217, 
	188, 186, 187, 186, 187, 186, 187, 186, 
	217, 188, 186, 187, 186, 187, 186, 187, 
	186, 217, 190, 193, 196, 194, 195, 194, 
	195, 194, 195, 194, 189, 190, 189, 221, 
	190, 189, 188, 186, 187, 186, 187, 186, 
	187, 186, 217, 188, 186, 187, 186, 187, 
	186, 187, 186, 217, 190, 193, 196, 194, 
	195, 194, 195, 194, 195, 194, 189, 190, 
	196, 194, 195, 194, 195, 194, 195, 194, 
	189, 190, 196, 194, 195, 194, 195, 194, 
	195, 194, 189, 190, 193, 196, 194, 195, 
	194, 195, 194, 195, 194, 189, 140, 168, 
	166, 167, 166, 167, 166, 167, 166, 139, 
	170, 198, 201, 199, 200, 199, 200, 199, 
	200, 199, 169, 170, 201, 199, 200, 199, 
	200, 199, 200, 199, 169, 170, 201, 199, 
	200, 199, 200, 199, 200, 199, 169, 170, 
	198, 201, 199, 200, 199, 200, 199, 200, 
	199, 169, 164, 202, 205, 203, 204, 203, 
	204, 203, 204, 203, 163, 164, 205, 203, 
	204, 203, 204, 203, 204, 203, 163, 164, 
	205, 203, 204, 203, 204, 203, 204, 203, 
	163, 164, 202, 205, 203, 204, 203, 204, 
	203, 204, 203, 163, 140, 162, 160, 161, 
	160, 161, 160, 161, 160, 139, 208, 207, 
	1, 207, 0, 211, 212, 213, 214, 213, 
	214, 210, 210, 210, 33, 210, 60, 60, 
	210, 68, 68, 210, 124, 121, 0, 158, 
	159, 206, 159, 206, 159, 206, 159, 139, 
	140, 142, 139, 140, 171, 165, 197, 165, 
	197, 165, 197, 165, 139, 140, 171, 165, 
	197, 165, 197, 165, 197, 165, 139, 191, 
	192, 191, 192, 191, 192, 191, 217, 207, 
	207, 207, 207, 207, 207, 207, 207, 207, 
	207, 207, 207, 207, 207, 207, 207, 207, 
	207, 207, 207, 207, 207, 207, 207, 207, 
	207, 207, 210, 210, 210, 210, 210, 210, 
	210, 210, 210, 210, 210, 210, 210, 210, 
	210, 210, 210, 210, 210, 210, 210, 210, 
	210, 210, 210, 210, 210, 210, 210, 210, 
	210, 210, 210, 210, 210, 210, 210, 210, 
	210, 210, 210, 210, 210, 210, 210, 210, 
	210, 210, 210, 210, 210, 210, 210, 210, 
	210, 210, 210, 210, 210, 210, 210, 210, 
	210, 210, 210, 210, 210, 210, 210, 210, 
	210, 210, 210, 210, 210, 210, 210, 210, 
	210, 210, 210, 210, 210, 210, 210, 210, 
	210, 217, 217, 217, 217, 217, 217, 217, 
	217, 217, 217, 217, 217, 217, 217, 217, 
	217, 217, 217, 217, 217, 217, 217, 217, 
	217, 217, 217, 217, 217, 217, 217, 217, 
	217, 217, 217, 217, 217, 217, 217, 217, 
	217, 217, 217, 217, 217, 217, 217, 217, 
	217, 217, 217, 217, 217, 217, 217, 217, 
	217, 207, 210, 210, 210, 210, 217, 217, 
	217, 217, 0
]

class << self
	attr_accessor :_ami_protocol_parser_trans_actions
	private :_ami_protocol_parser_trans_actions, :_ami_protocol_parser_trans_actions=
end
self._ami_protocol_parser_trans_actions = [
	0, 49, 0, 49, 0, 49, 0, 49, 
	0, 49, 0, 49, 0, 49, 0, 49, 
	0, 49, 0, 49, 0, 49, 0, 49, 
	0, 49, 0, 49, 0, 49, 0, 49, 
	0, 49, 0, 49, 0, 49, 0, 49, 
	1, 49, 0, 0, 49, 0, 49, 3, 
	0, 49, 43, 49, 3, 0, 49, 0, 
	0, 49, 19, 19, 21, 0, 21, 0, 
	35, 21, 0, 0, 21, 0, 0, 63, 
	0, 63, 0, 63, 0, 63, 0, 63, 
	0, 63, 0, 63, 0, 63, 0, 63, 
	0, 63, 0, 63, 0, 63, 0, 63, 
	0, 63, 0, 63, 0, 63, 0, 63, 
	0, 63, 0, 63, 0, 63, 1, 63, 
	0, 0, 63, 0, 63, 3, 0, 63, 
	51, 63, 3, 0, 63, 0, 0, 63, 
	0, 0, 63, 0, 0, 63, 0, 0, 
	63, 0, 63, 90, 29, 29, 31, 0, 
	53, 31, 0, 90, 29, 29, 0, 0, 
	63, 0, 0, 63, 0, 0, 63, 0, 
	0, 63, 0, 0, 63, 0, 0, 63, 
	0, 63, 0, 0, 0, 0, 0, 0, 
	0, 0, 63, 0, 0, 0, 0, 0, 
	0, 0, 0, 63, 0, 0, 63, 0, 
	0, 63, 0, 0, 63, 0, 0, 63, 
	0, 63, 0, 63, 0, 0, 63, 0, 
	0, 63, 0, 0, 63, 0, 0, 63, 
	0, 0, 63, 0, 0, 63, 0, 0, 
	63, 0, 63, 13, 13, 13, 0, 0, 
	0, 0, 0, 0, 63, 84, 63, 13, 
	13, 13, 0, 63, 0, 63, 0, 63, 
	0, 63, 0, 63, 0, 63, 0, 63, 
	33, 63, 0, 63, 55, 63, 0, 0, 
	63, 0, 0, 63, 0, 0, 63, 23, 
	63, 96, 63, 0, 0, 63, 0, 0, 
	63, 0, 0, 63, 0, 0, 63, 0, 
	0, 63, 0, 0, 63, 23, 63, 93, 
	63, 15, 15, 0, 0, 0, 0, 0, 
	0, 0, 17, 0, 0, 0, 5, 5, 
	5, 5, 5, 5, 5, 0, 87, 0, 
	7, 0, 0, 0, 0, 0, 0, 0, 
	0, 7, 0, 0, 0, 0, 0, 0, 
	0, 0, 7, 0, 0, 0, 0, 0, 
	0, 0, 0, 81, 9, 78, 9, 9, 
	9, 9, 9, 9, 9, 9, 11, 0, 
	0, 11, 0, 0, 5, 5, 5, 5, 
	5, 5, 5, 0, 7, 0, 0, 0, 
	0, 0, 0, 0, 0, 81, 9, 78, 
	9, 9, 9, 9, 9, 9, 9, 9, 
	11, 7, 0, 0, 0, 0, 0, 0, 
	0, 0, 11, 7, 0, 0, 0, 0, 
	0, 0, 0, 0, 81, 9, 78, 9, 
	9, 9, 9, 9, 9, 9, 9, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 27, 
	0, 0, 73, 65, 73, 105, 0, 0, 
	0, 7, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 7, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 7, 0, 0, 
	0, 0, 0, 0, 0, 0, 81, 9, 
	78, 9, 9, 9, 9, 9, 9, 9, 
	9, 11, 0, 102, 11, 0, 0, 7, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 7, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 7, 0, 0, 0, 0, 
	0, 0, 0, 0, 81, 9, 78, 9, 
	9, 9, 9, 9, 9, 9, 9, 11, 
	0, 102, 11, 0, 0, 0, 7, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	7, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 7, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 7, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 7, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 7, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 7, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 7, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 7, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	7, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 7, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 7, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 7, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 27, 7, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 7, 
	0, 0, 0, 0, 0, 0, 0, 71, 
	7, 0, 0, 0, 0, 0, 0, 0, 
	71, 7, 0, 0, 0, 0, 0, 0, 
	0, 71, 81, 9, 78, 9, 9, 9, 
	9, 9, 9, 9, 9, 11, 0, 41, 
	11, 0, 7, 0, 0, 0, 0, 0, 
	0, 0, 71, 7, 0, 0, 0, 0, 
	0, 0, 0, 71, 81, 9, 78, 9, 
	9, 9, 9, 9, 9, 9, 9, 11, 
	7, 0, 0, 0, 0, 0, 0, 0, 
	0, 11, 7, 0, 0, 0, 0, 0, 
	0, 0, 0, 81, 9, 78, 9, 9, 
	9, 9, 9, 9, 9, 9, 0, 7, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	81, 9, 78, 9, 9, 9, 9, 9, 
	9, 9, 9, 11, 7, 0, 0, 0, 
	0, 0, 0, 0, 0, 11, 7, 0, 
	0, 0, 0, 0, 0, 0, 0, 81, 
	9, 78, 9, 9, 9, 9, 9, 9, 
	9, 9, 81, 9, 78, 9, 9, 9, 
	9, 9, 9, 9, 9, 11, 7, 0, 
	0, 0, 0, 0, 0, 0, 0, 11, 
	7, 0, 0, 0, 0, 0, 0, 0, 
	0, 81, 9, 78, 9, 9, 9, 9, 
	9, 9, 9, 9, 0, 7, 0, 0, 
	0, 0, 0, 0, 0, 0, 41, 45, 
	0, 47, 0, 0, 41, 41, 41, 41, 
	41, 59, 57, 61, 0, 61, 0, 0, 
	61, 0, 0, 61, 0, 0, 0, 25, 
	75, 75, 75, 75, 75, 75, 75, 25, 
	0, 0, 0, 0, 5, 5, 5, 5, 
	5, 5, 5, 5, 0, 0, 5, 5, 
	5, 5, 5, 5, 5, 5, 0, 5, 
	5, 5, 5, 5, 5, 5, 67, 49, 
	49, 49, 49, 49, 49, 49, 49, 49, 
	49, 49, 49, 49, 49, 49, 49, 49, 
	49, 49, 49, 49, 49, 49, 49, 49, 
	49, 49, 63, 63, 63, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 63, 63, 
	63, 63, 63, 63, 63, 63, 63, 63, 
	63, 73, 73, 73, 73, 73, 73, 73, 
	73, 73, 73, 73, 73, 73, 73, 73, 
	73, 73, 73, 73, 71, 71, 71, 71, 
	71, 71, 71, 71, 71, 71, 71, 71, 
	71, 71, 71, 71, 71, 71, 71, 71, 
	71, 71, 71, 71, 71, 71, 71, 71, 
	71, 71, 71, 71, 71, 71, 71, 71, 
	71, 47, 61, 61, 61, 61, 69, 67, 
	67, 67, 0
]

class << self
	attr_accessor :_ami_protocol_parser_to_state_actions
	private :_ami_protocol_parser_to_state_actions, :_ami_protocol_parser_to_state_actions=
end
self._ami_protocol_parser_to_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 37, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	37, 0, 0, 0, 0, 37, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 37, 
	0, 0, 37, 0, 0, 0, 0, 0, 
	0, 99, 0, 0, 0, 0
]

class << self
	attr_accessor :_ami_protocol_parser_from_state_actions
	private :_ami_protocol_parser_from_state_actions, :_ami_protocol_parser_from_state_actions=
end
self._ami_protocol_parser_from_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 39, 
	0, 0, 39, 0, 0, 0, 0, 0, 
	0, 39, 0, 0, 0, 0
]

class << self
	attr_accessor :_ami_protocol_parser_eof_trans
	private :_ami_protocol_parser_eof_trans, :_ami_protocol_parser_eof_trans=
end
self._ami_protocol_parser_eof_trans = [
	0, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 
	1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 
	1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 
	1026, 1026, 1026, 1026, 0, 0, 0, 0, 
	0, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	1113, 1113, 1113, 1113, 1113, 1113, 1113, 1113, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 1132, 1132, 1132, 1132, 1132, 
	1132, 1132, 1132, 1132, 1132, 1132, 1132, 1132, 
	1132, 1132, 1132, 1132, 1132, 1132, 0, 0, 
	0, 0, 0, 0, 0, 1169, 1169, 1169, 
	1169, 1169, 1169, 1169, 1169, 1169, 1169, 1169, 
	1169, 1169, 1169, 1169, 1169, 1169, 1169, 1169, 
	1169, 1169, 1169, 1169, 1169, 1169, 1169, 1169, 
	1169, 1169, 1169, 1169, 1169, 1169, 1169, 1169, 
	1169, 1169, 0, 0, 0, 0, 0, 0, 
	1170, 0, 0, 1174, 1174, 1174, 1174, 0, 
	0, 0, 1175, 1178, 1178, 1178
]

class << self
	attr_accessor :ami_protocol_parser_start
end
self.ami_protocol_parser_start = 207;
class << self
	attr_accessor :ami_protocol_parser_error
end
self.ami_protocol_parser_error = 0;

class << self
	attr_accessor :ami_protocol_parser_en_immediate_response
end
self.ami_protocol_parser_en_immediate_response = 28;
class << self
	attr_accessor :ami_protocol_parser_en_main
end
self.ami_protocol_parser_en_main = 207;
class << self
	attr_accessor :ami_protocol_parser_en_protocol
end
self.ami_protocol_parser_en_protocol = 210;
class << self
	attr_accessor :ami_protocol_parser_en_error_recovery
end
self.ami_protocol_parser_en_error_recovery = 120;
class << self
	attr_accessor :ami_protocol_parser_en_success
end
self.ami_protocol_parser_en_success = 125;
class << self
	attr_accessor :ami_protocol_parser_en_response_follows
end
self.ami_protocol_parser_en_response_follows = 217;


# line 793 "lib/adhearsion/voip/asterisk/new-ami/ami.rb"
begin
	 @current_pointer ||= 0
	 @data_ending_pointer ||=  @data.length
	 @current_state = ami_protocol_parser_start
	 @token_start = nil
	 @token_end = nil
	 @ragel_act = 0
end
# line 92 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"

  end
  
  def <<(new_data)
    if new_data.size + @data.size > BUFFER_SIZE
      @data.slice! 0...new_data.size
      @current_pointer = @data.size
    end
    @data << new_data
    @data_ending_pointer = @data.size
    resume!
  end
  
  def resume!
    
# line 818 "lib/adhearsion/voip/asterisk/new-ami/ami.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if  @current_pointer ==  @data_ending_pointer
		_goto_level = _test_eof
		next
	end
	if  @current_state == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_acts = _ami_protocol_parser_from_state_actions[ @current_state]
	_nacts = _ami_protocol_parser_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _ami_protocol_parser_actions[_acts - 1]
			when 26 then
# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_start =  @current_pointer
		end
# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
# line 853 "lib/adhearsion/voip/asterisk/new-ami/ami.rb"
		end # from state action switch
	end
	if _trigger_goto
		next
	end
	_keys = _ami_protocol_parser_key_offsets[ @current_state]
	_trans = _ami_protocol_parser_index_offsets[ @current_state]
	_klen = _ami_protocol_parser_single_lengths[ @current_state]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if  @data[ @current_pointer] < _ami_protocol_parser_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif  @data[ @current_pointer] > _ami_protocol_parser_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _ami_protocol_parser_range_lengths[ @current_state]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if  @data[ @current_pointer] < _ami_protocol_parser_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif  @data[ @current_pointer] > _ami_protocol_parser_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	end
	if _goto_level <= _eof_trans
	 @current_state = _ami_protocol_parser_trans_targs[_trans]
	if _ami_protocol_parser_trans_actions[_trans] != 0
		_acts = _ami_protocol_parser_trans_actions[_trans]
		_nacts = _ami_protocol_parser_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _ami_protocol_parser_actions[_acts - 1]
when 0 then
# line 19 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 open_version 		end
# line 19 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 1 then
# line 20 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 close_version 		end
# line 20 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 2 then
# line 22 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 begin_capturing_key  		end
# line 22 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 3 then
# line 23 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 finish_capturing_key 		end
# line 23 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 4 then
# line 25 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 begin_capturing_value  		end
# line 25 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 5 then
# line 26 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 finish_capturing_value 		end
# line 26 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 6 then
# line 28 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 error_reason_start 		end
# line 28 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 7 then
# line 29 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 error_reason_end; 	begin
		 @current_state = 210
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
# line 29 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 8 then
# line 31 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 message_received @current_message 		end
# line 31 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 9 then
# line 33 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin

      start_ignoring_syntax_error;
    		end
# line 33 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 10 then
# line 36 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin

      end_ignoring_syntax_error;
      	begin
		 @current_state = 210
		_trigger_goto = true
		_goto_level = _again
		break
	end

    		end
# line 36 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 11 then
# line 41 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin

      start_capturing_immediate_response;
    		end
# line 41 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 12 then
# line 45 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin

      finish_capturing_immediate_response;
    		end
# line 45 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 13 then
# line 50 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin

      @current_message = NormalAmiResponse.new
    		end
# line 50 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 14 then
# line 54 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 start_capturing_follows_text 		end
# line 54 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 15 then
# line 55 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin

      end_capturing_follows_text;
    		end
# line 55 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 16 then
# line 59 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 begin_capturing_event_name 		end
# line 59 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 17 then
# line 60 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 init_event 		end
# line 60 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 18 then
# line 62 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin

      @current_message = NormalAmiResponse.new(true)
      	begin
		 @current_state = 217
		_trigger_goto = true
		_goto_level = _again
		break
	end

    		end
# line 62 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 19 then
# line 28 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 	begin
		 @current_state = 125
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
# line 28 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 20 then
# line 29 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 	begin
		 @current_state = 125
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
# line 29 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 21 then
# line 38 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 	begin
		 @current_state = 210
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
# line 38 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 22 then
# line 67 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 	begin
		 @current_state = 210
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
# line 67 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 23 then
# line 73 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 message_received; 	begin
		 @current_state = 210
		_trigger_goto = true
		_goto_level = _again
		break
	end
 		end
# line 73 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 27 then
# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer+1
		end
# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 28 then
# line 44 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer+1
 begin  	begin
		 @current_state = 210
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
# line 44 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 29 then
# line 45 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer+1
 begin 
    # If this scanner's look-ahead capability didn't match the prompt, let's ignore the need for a prompt
     @current_pointer =  @current_pointer - 1;
    	begin
		 @current_state = 210
		_trigger_goto = true
		_goto_level = _again
		break
	end

   end
		end
# line 45 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 30 then
# line 45 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer
 @current_pointer =  @current_pointer - 1; begin 
    # If this scanner's look-ahead capability didn't match the prompt, let's ignore the need for a prompt
     @current_pointer =  @current_pointer - 1;
    	begin
		 @current_state = 210
		_trigger_goto = true
		_goto_level = _again
		break
	end

   end
		end
# line 45 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 31 then
# line 45 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 begin  @current_pointer = (( @token_end))-1; end
 begin 
    # If this scanner's look-ahead capability didn't match the prompt, let's ignore the need for a prompt
     @current_pointer =  @current_pointer - 1;
    	begin
		 @current_state = 210
		_trigger_goto = true
		_goto_level = _again
		break
	end

   end
		end
# line 45 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 32 then
# line 53 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer+1
		end
# line 53 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 33 then
# line 31 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer+1
 begin  message_received @current_message  end
		end
# line 31 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 34 then
# line 55 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer+1
		end
# line 55 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 35 then
# line 56 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer+1
		end
# line 56 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 36 then
# line 57 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer+1
 begin  	begin
		 @current_state = 210
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
# line 57 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 37 then
# line 58 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer+1
 begin 
     @current_pointer =  @current_pointer - 1;
    	begin
		 @current_state = 28
		_trigger_goto = true
		_goto_level = _again
		break
	end

   end
		end
# line 58 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 38 then
# line 58 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer
 @current_pointer =  @current_pointer - 1; begin 
     @current_pointer =  @current_pointer - 1;
    	begin
		 @current_state = 28
		_trigger_goto = true
		_goto_level = _again
		break
	end

   end
		end
# line 58 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 39 then
# line 58 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 begin  @current_pointer = (( @token_end))-1; end
 begin 
     @current_pointer =  @current_pointer - 1;
    	begin
		 @current_state = 28
		_trigger_goto = true
		_goto_level = _again
		break
	end

   end
		end
# line 58 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 40 then
# line 71 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @ragel_act = 9;		end
# line 71 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 41 then
# line 73 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @ragel_act = 11;		end
# line 73 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 42 then
# line 72 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer+1
		end
# line 72 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 43 then
# line 71 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer
 @current_pointer =  @current_pointer - 1;		end
# line 71 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 44 then
# line 73 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_end =  @current_pointer
 @current_pointer =  @current_pointer - 1;		end
# line 73 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 45 then
# line 71 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 begin  @current_pointer = (( @token_end))-1; end
		end
# line 71 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 46 then
# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
	case  @ragel_act
	when 0 then
	begin	begin
		 @current_state = 0
		_trigger_goto = true
		_goto_level = _again
		break
	end
end
	else
	begin begin  @current_pointer = (( @token_end))-1; end
end
end 
			end
# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
# line 1311 "lib/adhearsion/voip/asterisk/new-ami/ami.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	_acts = _ami_protocol_parser_to_state_actions[ @current_state]
	_nacts = _ami_protocol_parser_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _ami_protocol_parser_actions[_acts - 1]
when 24 then
# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @token_start = nil;		end
# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
when 25 then
# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
		begin
 @ragel_act = 0
		end
# line 1 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"
# line 1338 "lib/adhearsion/voip/asterisk/new-ami/ami.rb"
		end # to state action switch
	end
	if _trigger_goto
		next
	end
	if  @current_state == 0
		_goto_level = _out
		next
	end
	 @current_pointer += 1
	if  @current_pointer !=  @data_ending_pointer
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if  @current_pointer ==  @eof
	if _ami_protocol_parser_eof_trans[ @current_state] > 0
		_trans = _ami_protocol_parser_eof_trans[ @current_state] - 1;
		_goto_level = _eof_trans
		next;
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end
# line 106 "lib/adhearsion/voip/asterisk/new-ami/ami.rl"

  end
  
  protected
  
  def open_version
    @start_of_version = @current_pointer
  end
  
  def close_version
    self.ami_version = @data[@start_of_version...@current_pointer].to_f
    @start_of_version = nil
  end
  
  def begin_capturing_variable(variable_name)
    @start_of_current_capture = @current_pointer
  end
  
  def finish_capturing_variable(variable_name)
    start, stop = @start_of_current_capture, @current_pointer
    return :failed if !start || start > stop
    capture = @data[start...stop]
    CAPTURED_VARIABLES[variable_name] = capture
    capture
  end
  
  def begin_capturing_event_name
    @event_name_start = @current_pointer
  end
  
  def init_event
    event_name = @data[@event_name_start]
    @event_name_start = nil
    @current_message = Event.new(event_name)
  end
  
  # TODO: Add it to events system.
  def message_received(current_message=@current_message)
    current_message
  end
  
  def begin_capturing_key
    @current_key_position = @current_pointer
  end
  
  def finish_capturing_key
    @current_key = @data[@current_key_position...@current_pointer]
  end
  
  def begin_capturing_value
    @current_value_position = @current_pointer
  end
  
  def finish_capturing_value
    @current_value = @data[@current_value_position...@current_pointer]
    @last_seen_value_end = @current_pointer + 2 # 2 for \r\n
    add_pair_to_current_message
  end
  
  def error_reason_start
    @error_reason_start = @current_pointer
  end
  
  def error_reason_end
    ami_error! @data[@error_reason_start...@current_pointer - 3]
    @error_reason_start = nil
  end
  
  def start_capturing_follows_text
    @follows_text_start = @current_pointer
  end
  
  def end_capturing_follows_text
    text = @data[@last_seen_value_end..(@current_pointer - "\r\n--END COMMAND--".size)]
    @current_message.text = text
    @follows_text_start = nil
  end
  
  def add_pair_to_current_message
    @current_message[@current_key] = @current_value
    reset_key_and_value_positions
  end
  
  def reset_key_and_value_positions
    @current_key, @current_value, @current_key_position, @current_value_position = nil
  end
  
  def start_ignoring_syntax_error
    @current_syntax_error_start = @current_pointer # Adding 1 since the pointer is still set to the last successful match
  end
  
  def end_ignoring_syntax_error
    # Subtracting 3 from @current_pointer below for "\r\n\r" which separates a stanza
    offending_data = @data[@current_syntax_error_start...@current_pointer - 3]
    syntax_error! offending_data
    @current_syntax_error_start = nil
  end
  
  def start_capturing_immediate_response
    @immediate_response_start = @current_pointer
  end
  
  def finish_capturing_immediate_response
    message = @data[@immediate_response_start...@current_pointer]
    message_received ImmediateResponse.new(message)
  end
  
  # TODO: Invoke Theatre
  def ami_error!(reason)
    # raise "AMI Error: #{reason}"
  end
  
  # TODO: Invoke Theatre
  def syntax_error!(ignored_chunk)
    p "Ignoring this: #{ignored_chunk}"
  end
  
  def view_buffer(message=nil)
    
    message ||= "Viewing the buffer"
    
    buffer = @data.clone
    buffer.insert(@current_pointer, "\033[0;31m\033[1;31m^\033[0m")
    
    buffer.gsub!("\r", "\\\\r")
    buffer.gsub!("\n", "\\n\n")
    
    puts <<-INSPECTION

VVVVVVVVVVVVVVVVVVVVVVVVVVVVV
####  #{message}
#############################
#{buffer}
#############################
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    INSPECTION
    
  end
  
end