È
¾¢
^
AssignVariableOp
resource
value"dtype"
dtypetype"
validate_shapebool( 
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetype
E
Relu
features"T
activations"T"
Ttype:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
Á
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ¨
@
StaticRegexFullMatch	
input

output
"
patternstring
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 

VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 "serve*2.9.22unknown8þ

Adam/dense_204/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:*&
shared_nameAdam/dense_204/bias/v
{
)Adam/dense_204/bias/v/Read/ReadVariableOpReadVariableOpAdam/dense_204/bias/v*
_output_shapes
:*
dtype0

Adam/dense_204/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:d*(
shared_nameAdam/dense_204/kernel/v

+Adam/dense_204/kernel/v/Read/ReadVariableOpReadVariableOpAdam/dense_204/kernel/v*
_output_shapes

:d*
dtype0

Adam/dense_203/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:d*&
shared_nameAdam/dense_203/bias/v
{
)Adam/dense_203/bias/v/Read/ReadVariableOpReadVariableOpAdam/dense_203/bias/v*
_output_shapes
:d*
dtype0

Adam/dense_203/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:dd*(
shared_nameAdam/dense_203/kernel/v

+Adam/dense_203/kernel/v/Read/ReadVariableOpReadVariableOpAdam/dense_203/kernel/v*
_output_shapes

:dd*
dtype0

Adam/dense_202/bias/vVarHandleOp*
_output_shapes
: *
dtype0*
shape:d*&
shared_nameAdam/dense_202/bias/v
{
)Adam/dense_202/bias/v/Read/ReadVariableOpReadVariableOpAdam/dense_202/bias/v*
_output_shapes
:d*
dtype0

Adam/dense_202/kernel/vVarHandleOp*
_output_shapes
: *
dtype0*
shape
:d*(
shared_nameAdam/dense_202/kernel/v

+Adam/dense_202/kernel/v/Read/ReadVariableOpReadVariableOpAdam/dense_202/kernel/v*
_output_shapes

:d*
dtype0

Adam/dense_204/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:*&
shared_nameAdam/dense_204/bias/m
{
)Adam/dense_204/bias/m/Read/ReadVariableOpReadVariableOpAdam/dense_204/bias/m*
_output_shapes
:*
dtype0

Adam/dense_204/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:d*(
shared_nameAdam/dense_204/kernel/m

+Adam/dense_204/kernel/m/Read/ReadVariableOpReadVariableOpAdam/dense_204/kernel/m*
_output_shapes

:d*
dtype0

Adam/dense_203/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:d*&
shared_nameAdam/dense_203/bias/m
{
)Adam/dense_203/bias/m/Read/ReadVariableOpReadVariableOpAdam/dense_203/bias/m*
_output_shapes
:d*
dtype0

Adam/dense_203/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:dd*(
shared_nameAdam/dense_203/kernel/m

+Adam/dense_203/kernel/m/Read/ReadVariableOpReadVariableOpAdam/dense_203/kernel/m*
_output_shapes

:dd*
dtype0

Adam/dense_202/bias/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:d*&
shared_nameAdam/dense_202/bias/m
{
)Adam/dense_202/bias/m/Read/ReadVariableOpReadVariableOpAdam/dense_202/bias/m*
_output_shapes
:d*
dtype0

Adam/dense_202/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape
:d*(
shared_nameAdam/dense_202/kernel/m

+Adam/dense_202/kernel/m/Read/ReadVariableOpReadVariableOpAdam/dense_202/kernel/m*
_output_shapes

:d*
dtype0
^
countVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namecount
W
count/Read/ReadVariableOpReadVariableOpcount*
_output_shapes
: *
dtype0
^
totalVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nametotal
W
total/Read/ReadVariableOpReadVariableOptotal*
_output_shapes
: *
dtype0
b
count_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	count_1
[
count_1/Read/ReadVariableOpReadVariableOpcount_1*
_output_shapes
: *
dtype0
b
total_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	total_1
[
total_1/Read/ReadVariableOpReadVariableOptotal_1*
_output_shapes
: *
dtype0
b
count_2VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	count_2
[
count_2/Read/ReadVariableOpReadVariableOpcount_2*
_output_shapes
: *
dtype0
b
total_2VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	total_2
[
total_2/Read/ReadVariableOpReadVariableOptotal_2*
_output_shapes
: *
dtype0
x
Adam/learning_rateVarHandleOp*
_output_shapes
: *
dtype0*
shape: *#
shared_nameAdam/learning_rate
q
&Adam/learning_rate/Read/ReadVariableOpReadVariableOpAdam/learning_rate*
_output_shapes
: *
dtype0
h

Adam/decayVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name
Adam/decay
a
Adam/decay/Read/ReadVariableOpReadVariableOp
Adam/decay*
_output_shapes
: *
dtype0
j
Adam/beta_2VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nameAdam/beta_2
c
Adam/beta_2/Read/ReadVariableOpReadVariableOpAdam/beta_2*
_output_shapes
: *
dtype0
j
Adam/beta_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nameAdam/beta_1
c
Adam/beta_1/Read/ReadVariableOpReadVariableOpAdam/beta_1*
_output_shapes
: *
dtype0
f
	Adam/iterVarHandleOp*
_output_shapes
: *
dtype0	*
shape: *
shared_name	Adam/iter
_
Adam/iter/Read/ReadVariableOpReadVariableOp	Adam/iter*
_output_shapes
: *
dtype0	
t
dense_204/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_namedense_204/bias
m
"dense_204/bias/Read/ReadVariableOpReadVariableOpdense_204/bias*
_output_shapes
:*
dtype0
|
dense_204/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:d*!
shared_namedense_204/kernel
u
$dense_204/kernel/Read/ReadVariableOpReadVariableOpdense_204/kernel*
_output_shapes

:d*
dtype0
t
dense_203/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:d*
shared_namedense_203/bias
m
"dense_203/bias/Read/ReadVariableOpReadVariableOpdense_203/bias*
_output_shapes
:d*
dtype0
|
dense_203/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:dd*!
shared_namedense_203/kernel
u
$dense_203/kernel/Read/ReadVariableOpReadVariableOpdense_203/kernel*
_output_shapes

:dd*
dtype0
t
dense_202/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:d*
shared_namedense_202/bias
m
"dense_202/bias/Read/ReadVariableOpReadVariableOpdense_202/bias*
_output_shapes
:d*
dtype0
|
dense_202/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:d*!
shared_namedense_202/kernel
u
$dense_202/kernel/Read/ReadVariableOpReadVariableOpdense_202/kernel*
_output_shapes

:d*
dtype0

NoOpNoOp
ø5
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*³5
value©5B¦5 B5
Î
layer-0
layer_with_weights-0
layer-1
layer_with_weights-1
layer-2
layer_with_weights-2
layer-3
	variables
trainable_variables
regularization_losses
	keras_api
	__call__
*
&call_and_return_all_conditional_losses
_default_save_signature
	optimizer

signatures*
¥
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses
_random_generator* 
¦
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses

kernel
bias*
¦
	variables
trainable_variables
regularization_losses
 	keras_api
!__call__
*"&call_and_return_all_conditional_losses

#kernel
$bias*
¦
%	variables
&trainable_variables
'regularization_losses
(	keras_api
)__call__
**&call_and_return_all_conditional_losses

+kernel
,bias*
.
0
1
#2
$3
+4
,5*
.
0
1
#2
$3
+4
,5*
* 
°
-non_trainable_variables

.layers
/metrics
0layer_regularization_losses
1layer_metrics
	variables
trainable_variables
regularization_losses
	__call__
_default_save_signature
*
&call_and_return_all_conditional_losses
&
"call_and_return_conditional_losses*
6
2trace_0
3trace_1
4trace_2
5trace_3* 
6
6trace_0
7trace_1
8trace_2
9trace_3* 
* 
°
:iter

;beta_1

<beta_2
	=decay
>learning_ratemomp#mq$mr+ms,mtvuvv#vw$vx+vy,vz*

?serving_default* 
* 
* 
* 

@non_trainable_variables

Alayers
Bmetrics
Clayer_regularization_losses
Dlayer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses* 

Etrace_0
Ftrace_1* 

Gtrace_0
Htrace_1* 
* 

0
1*

0
1*
* 

Inon_trainable_variables

Jlayers
Kmetrics
Llayer_regularization_losses
Mlayer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses*

Ntrace_0* 

Otrace_0* 
`Z
VARIABLE_VALUEdense_202/kernel6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUE*
\V
VARIABLE_VALUEdense_202/bias4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUE*

#0
$1*

#0
$1*
* 

Pnon_trainable_variables

Qlayers
Rmetrics
Slayer_regularization_losses
Tlayer_metrics
	variables
trainable_variables
regularization_losses
!__call__
*"&call_and_return_all_conditional_losses
&""call_and_return_conditional_losses*

Utrace_0* 

Vtrace_0* 
`Z
VARIABLE_VALUEdense_203/kernel6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUE*
\V
VARIABLE_VALUEdense_203/bias4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUE*

+0
,1*

+0
,1*
* 

Wnon_trainable_variables

Xlayers
Ymetrics
Zlayer_regularization_losses
[layer_metrics
%	variables
&trainable_variables
'regularization_losses
)__call__
**&call_and_return_all_conditional_losses
&*"call_and_return_conditional_losses*

\trace_0* 

]trace_0* 
`Z
VARIABLE_VALUEdense_204/kernel6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUE*
\V
VARIABLE_VALUEdense_204/bias4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUE*
* 
 
0
1
2
3*

^0
_1
`2*
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
LF
VARIABLE_VALUE	Adam/iter)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUE*
PJ
VARIABLE_VALUEAdam/beta_1+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUE*
PJ
VARIABLE_VALUEAdam/beta_2+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUE*
NH
VARIABLE_VALUE
Adam/decay*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUE*
^X
VARIABLE_VALUEAdam/learning_rate2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUE*
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
8
a	variables
b	keras_api
	ctotal
	dcount*
H
e	variables
f	keras_api
	gtotal
	hcount
i
_fn_kwargs*
H
j	variables
k	keras_api
	ltotal
	mcount
n
_fn_kwargs*

c0
d1*

a	variables*
UO
VARIABLE_VALUEtotal_24keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUE*
UO
VARIABLE_VALUEcount_24keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUE*

g0
h1*

e	variables*
UO
VARIABLE_VALUEtotal_14keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUE*
UO
VARIABLE_VALUEcount_14keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUE*
* 

l0
m1*

j	variables*
SM
VARIABLE_VALUEtotal4keras_api/metrics/2/total/.ATTRIBUTES/VARIABLE_VALUE*
SM
VARIABLE_VALUEcount4keras_api/metrics/2/count/.ATTRIBUTES/VARIABLE_VALUE*
* 
}
VARIABLE_VALUEAdam/dense_202/kernel/mRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
y
VARIABLE_VALUEAdam/dense_202/bias/mPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
}
VARIABLE_VALUEAdam/dense_203/kernel/mRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
y
VARIABLE_VALUEAdam/dense_203/bias/mPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
}
VARIABLE_VALUEAdam/dense_204/kernel/mRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
y
VARIABLE_VALUEAdam/dense_204/bias/mPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE*
}
VARIABLE_VALUEAdam/dense_202/kernel/vRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
y
VARIABLE_VALUEAdam/dense_202/bias/vPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
}
VARIABLE_VALUEAdam/dense_203/kernel/vRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
y
VARIABLE_VALUEAdam/dense_203/bias/vPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
}
VARIABLE_VALUEAdam/dense_204/kernel/vRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
y
VARIABLE_VALUEAdam/dense_204/bias/vPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
{
serving_default_input_57Placeholder*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*
dtype0*
shape:ÿÿÿÿÿÿÿÿÿ
§
StatefulPartitionedCallStatefulPartitionedCallserving_default_input_57dense_202/kerneldense_202/biasdense_203/kerneldense_203/biasdense_204/kerneldense_204/bias*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8 */
f*R(
&__inference_signature_wrapper_13955169
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
û

StatefulPartitionedCall_1StatefulPartitionedCallsaver_filename$dense_202/kernel/Read/ReadVariableOp"dense_202/bias/Read/ReadVariableOp$dense_203/kernel/Read/ReadVariableOp"dense_203/bias/Read/ReadVariableOp$dense_204/kernel/Read/ReadVariableOp"dense_204/bias/Read/ReadVariableOpAdam/iter/Read/ReadVariableOpAdam/beta_1/Read/ReadVariableOpAdam/beta_2/Read/ReadVariableOpAdam/decay/Read/ReadVariableOp&Adam/learning_rate/Read/ReadVariableOptotal_2/Read/ReadVariableOpcount_2/Read/ReadVariableOptotal_1/Read/ReadVariableOpcount_1/Read/ReadVariableOptotal/Read/ReadVariableOpcount/Read/ReadVariableOp+Adam/dense_202/kernel/m/Read/ReadVariableOp)Adam/dense_202/bias/m/Read/ReadVariableOp+Adam/dense_203/kernel/m/Read/ReadVariableOp)Adam/dense_203/bias/m/Read/ReadVariableOp+Adam/dense_204/kernel/m/Read/ReadVariableOp)Adam/dense_204/bias/m/Read/ReadVariableOp+Adam/dense_202/kernel/v/Read/ReadVariableOp)Adam/dense_202/bias/v/Read/ReadVariableOp+Adam/dense_203/kernel/v/Read/ReadVariableOp)Adam/dense_203/bias/v/Read/ReadVariableOp+Adam/dense_204/kernel/v/Read/ReadVariableOp)Adam/dense_204/bias/v/Read/ReadVariableOpConst**
Tin#
!2	*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 **
f%R#
!__inference__traced_save_13955440
²
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenamedense_202/kerneldense_202/biasdense_203/kerneldense_203/biasdense_204/kerneldense_204/bias	Adam/iterAdam/beta_1Adam/beta_2
Adam/decayAdam/learning_ratetotal_2count_2total_1count_1totalcountAdam/dense_202/kernel/mAdam/dense_202/bias/mAdam/dense_203/kernel/mAdam/dense_203/bias/mAdam/dense_204/kernel/mAdam/dense_204/bias/mAdam/dense_202/kernel/vAdam/dense_202/bias/vAdam/dense_203/kernel/vAdam/dense_203/bias/vAdam/dense_204/kernel/vAdam/dense_204/bias/v*)
Tin"
 2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *-
f(R&
$__inference__traced_restore_13955537¦ü
¤
®
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955072

inputs$
dense_202_13955056:d 
dense_202_13955058:d$
dense_203_13955061:dd 
dense_203_13955063:d$
dense_204_13955066:d 
dense_204_13955068:
identity¢!dense_202/StatefulPartitionedCall¢!dense_203/StatefulPartitionedCall¢!dense_204/StatefulPartitionedCall¾
dropout_56/PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *Q
fLRJ
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955030
!dense_202/StatefulPartitionedCallStatefulPartitionedCall#dropout_56/PartitionedCall:output:0dense_202_13955056dense_202_13955058*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_202_layer_call_and_return_conditional_losses_13954933
!dense_203/StatefulPartitionedCallStatefulPartitionedCall*dense_202/StatefulPartitionedCall:output:0dense_203_13955061dense_203_13955063*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_203_layer_call_and_return_conditional_losses_13954950
!dense_204/StatefulPartitionedCallStatefulPartitionedCall*dense_203/StatefulPartitionedCall:output:0dense_204_13955066dense_204_13955068*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_204_layer_call_and_return_conditional_losses_13954966y
IdentityIdentity*dense_204/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ²
NoOpNoOp"^dense_202/StatefulPartitionedCall"^dense_203/StatefulPartitionedCall"^dense_204/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 2F
!dense_202/StatefulPartitionedCall!dense_202/StatefulPartitionedCall2F
!dense_203/StatefulPartitionedCall!dense_203/StatefulPartitionedCall2F
!dense_204/StatefulPartitionedCall!dense_204/StatefulPartitionedCall:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
ª
°
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955124
input_57$
dense_202_13955108:d 
dense_202_13955110:d$
dense_203_13955113:dd 
dense_203_13955115:d$
dense_204_13955118:d 
dense_204_13955120:
identity¢!dense_202/StatefulPartitionedCall¢!dense_203/StatefulPartitionedCall¢!dense_204/StatefulPartitionedCallÀ
dropout_56/PartitionedCallPartitionedCallinput_57*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *Q
fLRJ
H__inference_dropout_56_layer_call_and_return_conditional_losses_13954920
!dense_202/StatefulPartitionedCallStatefulPartitionedCall#dropout_56/PartitionedCall:output:0dense_202_13955108dense_202_13955110*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_202_layer_call_and_return_conditional_losses_13954933
!dense_203/StatefulPartitionedCallStatefulPartitionedCall*dense_202/StatefulPartitionedCall:output:0dense_203_13955113dense_203_13955115*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_203_layer_call_and_return_conditional_losses_13954950
!dense_204/StatefulPartitionedCallStatefulPartitionedCall*dense_203/StatefulPartitionedCall:output:0dense_204_13955118dense_204_13955120*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_204_layer_call_and_return_conditional_losses_13954966y
IdentityIdentity*dense_204/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ²
NoOpNoOp"^dense_202/StatefulPartitionedCall"^dense_203/StatefulPartitionedCall"^dense_204/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 2F
!dense_202/StatefulPartitionedCall!dense_202/StatefulPartitionedCall2F
!dense_203/StatefulPartitionedCall!dense_203/StatefulPartitionedCall2F
!dense_204/StatefulPartitionedCall!dense_204/StatefulPartitionedCall:Q M
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
input_57
Ì

&__inference_signature_wrapper_13955169
input_57
unknown:d
	unknown_0:d
	unknown_1:dd
	unknown_2:d
	unknown_3:d
	unknown_4:
identity¢StatefulPartitionedCallî
StatefulPartitionedCallStatefulPartitionedCallinput_57unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8 *,
f'R%
#__inference__wrapped_model_13954908o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:Q M
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
input_57
È

,__inference_dense_203_layer_call_fn_13955300

inputs
unknown:dd
	unknown_0:d
identity¢StatefulPartitionedCallÜ
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_203_layer_call_and_return_conditional_losses_13954950o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:ÿÿÿÿÿÿÿÿÿd: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
 
_user_specified_nameinputs
ø

0__inference_sequential_56_layer_call_fn_13955186

inputs
unknown:d
	unknown_0:d
	unknown_1:dd
	unknown_2:d
	unknown_3:d
	unknown_4:
identity¢StatefulPartitionedCall
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8 *T
fORM
K__inference_sequential_56_layer_call_and_return_conditional_losses_13954973o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
Ê	
ø
G__inference_dense_204_layer_call_and_return_conditional_losses_13955330

inputs0
matmul_readvariableop_resource:d-
biasadd_readvariableop_resource:
identity¢BiasAdd/ReadVariableOp¢MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:d*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿr
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ_
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿw
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:ÿÿÿÿÿÿÿÿÿd: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
 
_user_specified_nameinputs
÷s

$__inference__traced_restore_13955537
file_prefix3
!assignvariableop_dense_202_kernel:d/
!assignvariableop_1_dense_202_bias:d5
#assignvariableop_2_dense_203_kernel:dd/
!assignvariableop_3_dense_203_bias:d5
#assignvariableop_4_dense_204_kernel:d/
!assignvariableop_5_dense_204_bias:&
assignvariableop_6_adam_iter:	 (
assignvariableop_7_adam_beta_1: (
assignvariableop_8_adam_beta_2: '
assignvariableop_9_adam_decay: 0
&assignvariableop_10_adam_learning_rate: %
assignvariableop_11_total_2: %
assignvariableop_12_count_2: %
assignvariableop_13_total_1: %
assignvariableop_14_count_1: #
assignvariableop_15_total: #
assignvariableop_16_count: =
+assignvariableop_17_adam_dense_202_kernel_m:d7
)assignvariableop_18_adam_dense_202_bias_m:d=
+assignvariableop_19_adam_dense_203_kernel_m:dd7
)assignvariableop_20_adam_dense_203_bias_m:d=
+assignvariableop_21_adam_dense_204_kernel_m:d7
)assignvariableop_22_adam_dense_204_bias_m:=
+assignvariableop_23_adam_dense_202_kernel_v:d7
)assignvariableop_24_adam_dense_202_bias_v:d=
+assignvariableop_25_adam_dense_203_kernel_v:dd7
)assignvariableop_26_adam_dense_203_bias_v:d=
+assignvariableop_27_adam_dense_204_kernel_v:d7
)assignvariableop_28_adam_dense_204_bias_v:
identity_30¢AssignVariableOp¢AssignVariableOp_1¢AssignVariableOp_10¢AssignVariableOp_11¢AssignVariableOp_12¢AssignVariableOp_13¢AssignVariableOp_14¢AssignVariableOp_15¢AssignVariableOp_16¢AssignVariableOp_17¢AssignVariableOp_18¢AssignVariableOp_19¢AssignVariableOp_2¢AssignVariableOp_20¢AssignVariableOp_21¢AssignVariableOp_22¢AssignVariableOp_23¢AssignVariableOp_24¢AssignVariableOp_25¢AssignVariableOp_26¢AssignVariableOp_27¢AssignVariableOp_28¢AssignVariableOp_3¢AssignVariableOp_4¢AssignVariableOp_5¢AssignVariableOp_6¢AssignVariableOp_7¢AssignVariableOp_8¢AssignVariableOp_9ä
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueBýB6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/2/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/2/count/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH¬
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*O
valueFBDB B B B B B B B B B B B B B B B B B B B B B B B B B B B B B µ
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*
_output_shapesz
x::::::::::::::::::::::::::::::*,
dtypes"
 2	[
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOpAssignVariableOp!assignvariableop_dense_202_kernelIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_1AssignVariableOp!assignvariableop_1_dense_202_biasIdentity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_2AssignVariableOp#assignvariableop_2_dense_203_kernelIdentity_2:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_3AssignVariableOp!assignvariableop_3_dense_203_biasIdentity_3:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_4IdentityRestoreV2:tensors:4"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_4AssignVariableOp#assignvariableop_4_dense_204_kernelIdentity_4:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_5IdentityRestoreV2:tensors:5"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_5AssignVariableOp!assignvariableop_5_dense_204_biasIdentity_5:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_6IdentityRestoreV2:tensors:6"/device:CPU:0*
T0	*
_output_shapes
:
AssignVariableOp_6AssignVariableOpassignvariableop_6_adam_iterIdentity_6:output:0"/device:CPU:0*
_output_shapes
 *
dtype0	]

Identity_7IdentityRestoreV2:tensors:7"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_7AssignVariableOpassignvariableop_7_adam_beta_1Identity_7:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_8IdentityRestoreV2:tensors:8"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_8AssignVariableOpassignvariableop_8_adam_beta_2Identity_8:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_9IdentityRestoreV2:tensors:9"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_9AssignVariableOpassignvariableop_9_adam_decayIdentity_9:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_10IdentityRestoreV2:tensors:10"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_10AssignVariableOp&assignvariableop_10_adam_learning_rateIdentity_10:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_11IdentityRestoreV2:tensors:11"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_11AssignVariableOpassignvariableop_11_total_2Identity_11:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_12IdentityRestoreV2:tensors:12"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_12AssignVariableOpassignvariableop_12_count_2Identity_12:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_13IdentityRestoreV2:tensors:13"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_13AssignVariableOpassignvariableop_13_total_1Identity_13:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_14IdentityRestoreV2:tensors:14"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_14AssignVariableOpassignvariableop_14_count_1Identity_14:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_15IdentityRestoreV2:tensors:15"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_15AssignVariableOpassignvariableop_15_totalIdentity_15:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_16IdentityRestoreV2:tensors:16"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_16AssignVariableOpassignvariableop_16_countIdentity_16:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_17IdentityRestoreV2:tensors:17"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_17AssignVariableOp+assignvariableop_17_adam_dense_202_kernel_mIdentity_17:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_18IdentityRestoreV2:tensors:18"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_18AssignVariableOp)assignvariableop_18_adam_dense_202_bias_mIdentity_18:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_19IdentityRestoreV2:tensors:19"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_19AssignVariableOp+assignvariableop_19_adam_dense_203_kernel_mIdentity_19:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_20IdentityRestoreV2:tensors:20"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_20AssignVariableOp)assignvariableop_20_adam_dense_203_bias_mIdentity_20:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_21IdentityRestoreV2:tensors:21"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_21AssignVariableOp+assignvariableop_21_adam_dense_204_kernel_mIdentity_21:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_22IdentityRestoreV2:tensors:22"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_22AssignVariableOp)assignvariableop_22_adam_dense_204_bias_mIdentity_22:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_23IdentityRestoreV2:tensors:23"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_23AssignVariableOp+assignvariableop_23_adam_dense_202_kernel_vIdentity_23:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_24IdentityRestoreV2:tensors:24"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_24AssignVariableOp)assignvariableop_24_adam_dense_202_bias_vIdentity_24:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_25IdentityRestoreV2:tensors:25"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_25AssignVariableOp+assignvariableop_25_adam_dense_203_kernel_vIdentity_25:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_26IdentityRestoreV2:tensors:26"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_26AssignVariableOp)assignvariableop_26_adam_dense_203_bias_vIdentity_26:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_27IdentityRestoreV2:tensors:27"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_27AssignVariableOp+assignvariableop_27_adam_dense_204_kernel_vIdentity_27:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_28IdentityRestoreV2:tensors:28"/device:CPU:0*
T0*
_output_shapes
:
AssignVariableOp_28AssignVariableOp)assignvariableop_28_adam_dense_204_bias_vIdentity_28:output:0"/device:CPU:0*
_output_shapes
 *
dtype01
NoOpNoOp"/device:CPU:0*
_output_shapes
 Í
Identity_29Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_19^AssignVariableOp_2^AssignVariableOp_20^AssignVariableOp_21^AssignVariableOp_22^AssignVariableOp_23^AssignVariableOp_24^AssignVariableOp_25^AssignVariableOp_26^AssignVariableOp_27^AssignVariableOp_28^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9^NoOp"/device:CPU:0*
T0*
_output_shapes
: W
Identity_30IdentityIdentity_29:output:0^NoOp_1*
T0*
_output_shapes
: º
NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_19^AssignVariableOp_2^AssignVariableOp_20^AssignVariableOp_21^AssignVariableOp_22^AssignVariableOp_23^AssignVariableOp_24^AssignVariableOp_25^AssignVariableOp_26^AssignVariableOp_27^AssignVariableOp_28^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9*"
_acd_function_control_output(*
_output_shapes
 "#
identity_30Identity_30:output:0*O
_input_shapes>
<: : : : : : : : : : : : : : : : : : : : : : : : : : : : : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_12*
AssignVariableOp_10AssignVariableOp_102*
AssignVariableOp_11AssignVariableOp_112*
AssignVariableOp_12AssignVariableOp_122*
AssignVariableOp_13AssignVariableOp_132*
AssignVariableOp_14AssignVariableOp_142*
AssignVariableOp_15AssignVariableOp_152*
AssignVariableOp_16AssignVariableOp_162*
AssignVariableOp_17AssignVariableOp_172*
AssignVariableOp_18AssignVariableOp_182*
AssignVariableOp_19AssignVariableOp_192(
AssignVariableOp_2AssignVariableOp_22*
AssignVariableOp_20AssignVariableOp_202*
AssignVariableOp_21AssignVariableOp_212*
AssignVariableOp_22AssignVariableOp_222*
AssignVariableOp_23AssignVariableOp_232*
AssignVariableOp_24AssignVariableOp_242*
AssignVariableOp_25AssignVariableOp_252*
AssignVariableOp_26AssignVariableOp_262*
AssignVariableOp_27AssignVariableOp_272*
AssignVariableOp_28AssignVariableOp_282(
AssignVariableOp_3AssignVariableOp_32(
AssignVariableOp_4AssignVariableOp_42(
AssignVariableOp_5AssignVariableOp_52(
AssignVariableOp_6AssignVariableOp_62(
AssignVariableOp_7AssignVariableOp_72(
AssignVariableOp_8AssignVariableOp_82(
AssignVariableOp_9AssignVariableOp_9:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
ø
d
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955030

inputs
identityN
IdentityIdentityinputs*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:ÿÿÿÿÿÿÿÿÿ:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
ª
°
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955144
input_57$
dense_202_13955128:d 
dense_202_13955130:d$
dense_203_13955133:dd 
dense_203_13955135:d$
dense_204_13955138:d 
dense_204_13955140:
identity¢!dense_202/StatefulPartitionedCall¢!dense_203/StatefulPartitionedCall¢!dense_204/StatefulPartitionedCallÀ
dropout_56/PartitionedCallPartitionedCallinput_57*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *Q
fLRJ
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955030
!dense_202/StatefulPartitionedCallStatefulPartitionedCall#dropout_56/PartitionedCall:output:0dense_202_13955128dense_202_13955130*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_202_layer_call_and_return_conditional_losses_13954933
!dense_203/StatefulPartitionedCallStatefulPartitionedCall*dense_202/StatefulPartitionedCall:output:0dense_203_13955133dense_203_13955135*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_203_layer_call_and_return_conditional_losses_13954950
!dense_204/StatefulPartitionedCallStatefulPartitionedCall*dense_203/StatefulPartitionedCall:output:0dense_204_13955138dense_204_13955140*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_204_layer_call_and_return_conditional_losses_13954966y
IdentityIdentity*dense_204/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ²
NoOpNoOp"^dense_202/StatefulPartitionedCall"^dense_203/StatefulPartitionedCall"^dense_204/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 2F
!dense_202/StatefulPartitionedCall!dense_202/StatefulPartitionedCall2F
!dense_203/StatefulPartitionedCall!dense_203/StatefulPartitionedCall2F
!dense_204/StatefulPartitionedCall!dense_204/StatefulPartitionedCall:Q M
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
input_57
Û
f
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955267

inputs

identity_1N
IdentityIdentityinputs*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ[

Identity_1IdentityIdentity:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:ÿÿÿÿÿÿÿÿÿ:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
¥
I
-__inference_dropout_56_layer_call_fn_13955262

inputs
identity³
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *Q
fLRJ
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955030`
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:ÿÿÿÿÿÿÿÿÿ:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
¥
I
-__inference_dropout_56_layer_call_fn_13955257

inputs
identity³
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *Q
fLRJ
H__inference_dropout_56_layer_call_and_return_conditional_losses_13954920`
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:ÿÿÿÿÿÿÿÿÿ:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
È

,__inference_dense_204_layer_call_fn_13955320

inputs
unknown:d
	unknown_0:
identity¢StatefulPartitionedCallÜ
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_204_layer_call_and_return_conditional_losses_13954966o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:ÿÿÿÿÿÿÿÿÿd: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
 
_user_specified_nameinputs
ô

K__inference_sequential_56_layer_call_and_return_conditional_losses_13955228

inputs:
(dense_202_matmul_readvariableop_resource:d7
)dense_202_biasadd_readvariableop_resource:d:
(dense_203_matmul_readvariableop_resource:dd7
)dense_203_biasadd_readvariableop_resource:d:
(dense_204_matmul_readvariableop_resource:d7
)dense_204_biasadd_readvariableop_resource:
identity¢ dense_202/BiasAdd/ReadVariableOp¢dense_202/MatMul/ReadVariableOp¢ dense_203/BiasAdd/ReadVariableOp¢dense_203/MatMul/ReadVariableOp¢ dense_204/BiasAdd/ReadVariableOp¢dense_204/MatMul/ReadVariableOpY
dropout_56/IdentityIdentityinputs*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
dense_202/MatMul/ReadVariableOpReadVariableOp(dense_202_matmul_readvariableop_resource*
_output_shapes

:d*
dtype0
dense_202/MatMulMatMuldropout_56/Identity:output:0'dense_202/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
 dense_202/BiasAdd/ReadVariableOpReadVariableOp)dense_202_biasadd_readvariableop_resource*
_output_shapes
:d*
dtype0
dense_202/BiasAddBiasAdddense_202/MatMul:product:0(dense_202/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdd
dense_202/ReluReludense_202/BiasAdd:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
dense_203/MatMul/ReadVariableOpReadVariableOp(dense_203_matmul_readvariableop_resource*
_output_shapes

:dd*
dtype0
dense_203/MatMulMatMuldense_202/Relu:activations:0'dense_203/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
 dense_203/BiasAdd/ReadVariableOpReadVariableOp)dense_203_biasadd_readvariableop_resource*
_output_shapes
:d*
dtype0
dense_203/BiasAddBiasAdddense_203/MatMul:product:0(dense_203/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdd
dense_203/ReluReludense_203/BiasAdd:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
dense_204/MatMul/ReadVariableOpReadVariableOp(dense_204_matmul_readvariableop_resource*
_output_shapes

:d*
dtype0
dense_204/MatMulMatMuldense_203/Relu:activations:0'dense_204/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 dense_204/BiasAdd/ReadVariableOpReadVariableOp)dense_204_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0
dense_204/BiasAddBiasAdddense_204/MatMul:product:0(dense_204/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿi
IdentityIdentitydense_204/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
NoOpNoOp!^dense_202/BiasAdd/ReadVariableOp ^dense_202/MatMul/ReadVariableOp!^dense_203/BiasAdd/ReadVariableOp ^dense_203/MatMul/ReadVariableOp!^dense_204/BiasAdd/ReadVariableOp ^dense_204/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 2D
 dense_202/BiasAdd/ReadVariableOp dense_202/BiasAdd/ReadVariableOp2B
dense_202/MatMul/ReadVariableOpdense_202/MatMul/ReadVariableOp2D
 dense_203/BiasAdd/ReadVariableOp dense_203/BiasAdd/ReadVariableOp2B
dense_203/MatMul/ReadVariableOpdense_203/MatMul/ReadVariableOp2D
 dense_204/BiasAdd/ReadVariableOp dense_204/BiasAdd/ReadVariableOp2B
dense_204/MatMul/ReadVariableOpdense_204/MatMul/ReadVariableOp:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
ø

0__inference_sequential_56_layer_call_fn_13955203

inputs
unknown:d
	unknown_0:d
	unknown_1:dd
	unknown_2:d
	unknown_3:d
	unknown_4:
identity¢StatefulPartitionedCall
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8 *T
fORM
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955072o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
Ê>
î
!__inference__traced_save_13955440
file_prefix/
+savev2_dense_202_kernel_read_readvariableop-
)savev2_dense_202_bias_read_readvariableop/
+savev2_dense_203_kernel_read_readvariableop-
)savev2_dense_203_bias_read_readvariableop/
+savev2_dense_204_kernel_read_readvariableop-
)savev2_dense_204_bias_read_readvariableop(
$savev2_adam_iter_read_readvariableop	*
&savev2_adam_beta_1_read_readvariableop*
&savev2_adam_beta_2_read_readvariableop)
%savev2_adam_decay_read_readvariableop1
-savev2_adam_learning_rate_read_readvariableop&
"savev2_total_2_read_readvariableop&
"savev2_count_2_read_readvariableop&
"savev2_total_1_read_readvariableop&
"savev2_count_1_read_readvariableop$
 savev2_total_read_readvariableop$
 savev2_count_read_readvariableop6
2savev2_adam_dense_202_kernel_m_read_readvariableop4
0savev2_adam_dense_202_bias_m_read_readvariableop6
2savev2_adam_dense_203_kernel_m_read_readvariableop4
0savev2_adam_dense_203_bias_m_read_readvariableop6
2savev2_adam_dense_204_kernel_m_read_readvariableop4
0savev2_adam_dense_204_bias_m_read_readvariableop6
2savev2_adam_dense_202_kernel_v_read_readvariableop4
0savev2_adam_dense_202_bias_v_read_readvariableop6
2savev2_adam_dense_203_kernel_v_read_readvariableop4
0savev2_adam_dense_203_bias_v_read_readvariableop6
2savev2_adam_dense_204_kernel_v_read_readvariableop4
0savev2_adam_dense_204_bias_v_read_readvariableop
savev2_const

identity_1¢MergeV2Checkpointsw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : 
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: á
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueBýB6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/2/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/2/count/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH©
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*O
valueFBDB B B B B B B B B B B B B B B B B B B B B B B B B B B B B B Ù
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0+savev2_dense_202_kernel_read_readvariableop)savev2_dense_202_bias_read_readvariableop+savev2_dense_203_kernel_read_readvariableop)savev2_dense_203_bias_read_readvariableop+savev2_dense_204_kernel_read_readvariableop)savev2_dense_204_bias_read_readvariableop$savev2_adam_iter_read_readvariableop&savev2_adam_beta_1_read_readvariableop&savev2_adam_beta_2_read_readvariableop%savev2_adam_decay_read_readvariableop-savev2_adam_learning_rate_read_readvariableop"savev2_total_2_read_readvariableop"savev2_count_2_read_readvariableop"savev2_total_1_read_readvariableop"savev2_count_1_read_readvariableop savev2_total_read_readvariableop savev2_count_read_readvariableop2savev2_adam_dense_202_kernel_m_read_readvariableop0savev2_adam_dense_202_bias_m_read_readvariableop2savev2_adam_dense_203_kernel_m_read_readvariableop0savev2_adam_dense_203_bias_m_read_readvariableop2savev2_adam_dense_204_kernel_m_read_readvariableop0savev2_adam_dense_204_bias_m_read_readvariableop2savev2_adam_dense_202_kernel_v_read_readvariableop0savev2_adam_dense_202_bias_v_read_readvariableop2savev2_adam_dense_203_kernel_v_read_readvariableop0savev2_adam_dense_203_bias_v_read_readvariableop2savev2_adam_dense_204_kernel_v_read_readvariableop0savev2_adam_dense_204_bias_v_read_readvariableopsavev2_const"/device:CPU:0*
_output_shapes
 *,
dtypes"
 2	
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: Q

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: [
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 "!

identity_1Identity_1:output:0*¿
_input_shapes­
ª: :d:d:dd:d:d:: : : : : : : : : : : :d:d:dd:d:d::d:d:dd:d:d:: 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:$ 

_output_shapes

:d: 

_output_shapes
:d:$ 

_output_shapes

:dd: 

_output_shapes
:d:$ 

_output_shapes

:d: 

_output_shapes
::

_output_shapes
: :

_output_shapes
: :	

_output_shapes
: :


_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :$ 

_output_shapes

:d: 

_output_shapes
:d:$ 

_output_shapes

:dd: 

_output_shapes
:d:$ 

_output_shapes

:d: 

_output_shapes
::$ 

_output_shapes

:d: 

_output_shapes
:d:$ 

_output_shapes

:dd: 

_output_shapes
:d:$ 

_output_shapes

:d: 

_output_shapes
::

_output_shapes
: 
ø
d
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955271

inputs
identityN
IdentityIdentityinputs*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:ÿÿÿÿÿÿÿÿÿ:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
¤
®
K__inference_sequential_56_layer_call_and_return_conditional_losses_13954973

inputs$
dense_202_13954934:d 
dense_202_13954936:d$
dense_203_13954951:dd 
dense_203_13954953:d$
dense_204_13954967:d 
dense_204_13954969:
identity¢!dense_202/StatefulPartitionedCall¢!dense_203/StatefulPartitionedCall¢!dense_204/StatefulPartitionedCall¾
dropout_56/PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8 *Q
fLRJ
H__inference_dropout_56_layer_call_and_return_conditional_losses_13954920
!dense_202/StatefulPartitionedCallStatefulPartitionedCall#dropout_56/PartitionedCall:output:0dense_202_13954934dense_202_13954936*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_202_layer_call_and_return_conditional_losses_13954933
!dense_203/StatefulPartitionedCallStatefulPartitionedCall*dense_202/StatefulPartitionedCall:output:0dense_203_13954951dense_203_13954953*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_203_layer_call_and_return_conditional_losses_13954950
!dense_204/StatefulPartitionedCallStatefulPartitionedCall*dense_203/StatefulPartitionedCall:output:0dense_204_13954967dense_204_13954969*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_204_layer_call_and_return_conditional_losses_13954966y
IdentityIdentity*dense_204/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ²
NoOpNoOp"^dense_202/StatefulPartitionedCall"^dense_203/StatefulPartitionedCall"^dense_204/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 2F
!dense_202/StatefulPartitionedCall!dense_202/StatefulPartitionedCall2F
!dense_203/StatefulPartitionedCall!dense_203/StatefulPartitionedCall2F
!dense_204/StatefulPartitionedCall!dense_204/StatefulPartitionedCall:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
È

,__inference_dense_202_layer_call_fn_13955280

inputs
unknown:d
	unknown_0:d
identity¢StatefulPartitionedCallÜ
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8 *P
fKRI
G__inference_dense_202_layer_call_and_return_conditional_losses_13954933o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:ÿÿÿÿÿÿÿÿÿ: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
ð#

#__inference__wrapped_model_13954908
input_57H
6sequential_56_dense_202_matmul_readvariableop_resource:dE
7sequential_56_dense_202_biasadd_readvariableop_resource:dH
6sequential_56_dense_203_matmul_readvariableop_resource:ddE
7sequential_56_dense_203_biasadd_readvariableop_resource:dH
6sequential_56_dense_204_matmul_readvariableop_resource:dE
7sequential_56_dense_204_biasadd_readvariableop_resource:
identity¢.sequential_56/dense_202/BiasAdd/ReadVariableOp¢-sequential_56/dense_202/MatMul/ReadVariableOp¢.sequential_56/dense_203/BiasAdd/ReadVariableOp¢-sequential_56/dense_203/MatMul/ReadVariableOp¢.sequential_56/dense_204/BiasAdd/ReadVariableOp¢-sequential_56/dense_204/MatMul/ReadVariableOpi
!sequential_56/dropout_56/IdentityIdentityinput_57*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ¤
-sequential_56/dense_202/MatMul/ReadVariableOpReadVariableOp6sequential_56_dense_202_matmul_readvariableop_resource*
_output_shapes

:d*
dtype0½
sequential_56/dense_202/MatMulMatMul*sequential_56/dropout_56/Identity:output:05sequential_56/dense_202/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd¢
.sequential_56/dense_202/BiasAdd/ReadVariableOpReadVariableOp7sequential_56_dense_202_biasadd_readvariableop_resource*
_output_shapes
:d*
dtype0¾
sequential_56/dense_202/BiasAddBiasAdd(sequential_56/dense_202/MatMul:product:06sequential_56/dense_202/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
sequential_56/dense_202/ReluRelu(sequential_56/dense_202/BiasAdd:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd¤
-sequential_56/dense_203/MatMul/ReadVariableOpReadVariableOp6sequential_56_dense_203_matmul_readvariableop_resource*
_output_shapes

:dd*
dtype0½
sequential_56/dense_203/MatMulMatMul*sequential_56/dense_202/Relu:activations:05sequential_56/dense_203/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd¢
.sequential_56/dense_203/BiasAdd/ReadVariableOpReadVariableOp7sequential_56_dense_203_biasadd_readvariableop_resource*
_output_shapes
:d*
dtype0¾
sequential_56/dense_203/BiasAddBiasAdd(sequential_56/dense_203/MatMul:product:06sequential_56/dense_203/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
sequential_56/dense_203/ReluRelu(sequential_56/dense_203/BiasAdd:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd¤
-sequential_56/dense_204/MatMul/ReadVariableOpReadVariableOp6sequential_56_dense_204_matmul_readvariableop_resource*
_output_shapes

:d*
dtype0½
sequential_56/dense_204/MatMulMatMul*sequential_56/dense_203/Relu:activations:05sequential_56/dense_204/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ¢
.sequential_56/dense_204/BiasAdd/ReadVariableOpReadVariableOp7sequential_56_dense_204_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0¾
sequential_56/dense_204/BiasAddBiasAdd(sequential_56/dense_204/MatMul:product:06sequential_56/dense_204/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿw
IdentityIdentity(sequential_56/dense_204/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿé
NoOpNoOp/^sequential_56/dense_202/BiasAdd/ReadVariableOp.^sequential_56/dense_202/MatMul/ReadVariableOp/^sequential_56/dense_203/BiasAdd/ReadVariableOp.^sequential_56/dense_203/MatMul/ReadVariableOp/^sequential_56/dense_204/BiasAdd/ReadVariableOp.^sequential_56/dense_204/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 2`
.sequential_56/dense_202/BiasAdd/ReadVariableOp.sequential_56/dense_202/BiasAdd/ReadVariableOp2^
-sequential_56/dense_202/MatMul/ReadVariableOp-sequential_56/dense_202/MatMul/ReadVariableOp2`
.sequential_56/dense_203/BiasAdd/ReadVariableOp.sequential_56/dense_203/BiasAdd/ReadVariableOp2^
-sequential_56/dense_203/MatMul/ReadVariableOp-sequential_56/dense_203/MatMul/ReadVariableOp2`
.sequential_56/dense_204/BiasAdd/ReadVariableOp.sequential_56/dense_204/BiasAdd/ReadVariableOp2^
-sequential_56/dense_204/MatMul/ReadVariableOp-sequential_56/dense_204/MatMul/ReadVariableOp:Q M
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
input_57
þ

0__inference_sequential_56_layer_call_fn_13954988
input_57
unknown:d
	unknown_0:d
	unknown_1:dd
	unknown_2:d
	unknown_3:d
	unknown_4:
identity¢StatefulPartitionedCall
StatefulPartitionedCallStatefulPartitionedCallinput_57unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8 *T
fORM
K__inference_sequential_56_layer_call_and_return_conditional_losses_13954973o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:Q M
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
input_57


ø
G__inference_dense_202_layer_call_and_return_conditional_losses_13954933

inputs0
matmul_readvariableop_resource:d-
biasadd_readvariableop_resource:d
identity¢BiasAdd/ReadVariableOp¢MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:d*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdr
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:d*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdP
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿda
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdw
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:ÿÿÿÿÿÿÿÿÿ: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs


ø
G__inference_dense_203_layer_call_and_return_conditional_losses_13955311

inputs0
matmul_readvariableop_resource:dd-
biasadd_readvariableop_resource:d
identity¢BiasAdd/ReadVariableOp¢MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:dd*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdr
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:d*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdP
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿda
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdw
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:ÿÿÿÿÿÿÿÿÿd: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
 
_user_specified_nameinputs


K__inference_sequential_56_layer_call_and_return_conditional_losses_13955252

inputs:
(dense_202_matmul_readvariableop_resource:d7
)dense_202_biasadd_readvariableop_resource:d:
(dense_203_matmul_readvariableop_resource:dd7
)dense_203_biasadd_readvariableop_resource:d:
(dense_204_matmul_readvariableop_resource:d7
)dense_204_biasadd_readvariableop_resource:
identity¢ dense_202/BiasAdd/ReadVariableOp¢dense_202/MatMul/ReadVariableOp¢ dense_203/BiasAdd/ReadVariableOp¢dense_203/MatMul/ReadVariableOp¢ dense_204/BiasAdd/ReadVariableOp¢dense_204/MatMul/ReadVariableOp
dense_202/MatMul/ReadVariableOpReadVariableOp(dense_202_matmul_readvariableop_resource*
_output_shapes

:d*
dtype0}
dense_202/MatMulMatMulinputs'dense_202/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
 dense_202/BiasAdd/ReadVariableOpReadVariableOp)dense_202_biasadd_readvariableop_resource*
_output_shapes
:d*
dtype0
dense_202/BiasAddBiasAdddense_202/MatMul:product:0(dense_202/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdd
dense_202/ReluReludense_202/BiasAdd:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
dense_203/MatMul/ReadVariableOpReadVariableOp(dense_203_matmul_readvariableop_resource*
_output_shapes

:dd*
dtype0
dense_203/MatMulMatMuldense_202/Relu:activations:0'dense_203/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
 dense_203/BiasAdd/ReadVariableOpReadVariableOp)dense_203_biasadd_readvariableop_resource*
_output_shapes
:d*
dtype0
dense_203/BiasAddBiasAdddense_203/MatMul:product:0(dense_203/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdd
dense_203/ReluReludense_203/BiasAdd:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
dense_204/MatMul/ReadVariableOpReadVariableOp(dense_204_matmul_readvariableop_resource*
_output_shapes

:d*
dtype0
dense_204/MatMulMatMuldense_203/Relu:activations:0'dense_204/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 dense_204/BiasAdd/ReadVariableOpReadVariableOp)dense_204_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0
dense_204/BiasAddBiasAdddense_204/MatMul:product:0(dense_204/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿi
IdentityIdentitydense_204/BiasAdd:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
NoOpNoOp!^dense_202/BiasAdd/ReadVariableOp ^dense_202/MatMul/ReadVariableOp!^dense_203/BiasAdd/ReadVariableOp ^dense_203/MatMul/ReadVariableOp!^dense_204/BiasAdd/ReadVariableOp ^dense_204/MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 2D
 dense_202/BiasAdd/ReadVariableOp dense_202/BiasAdd/ReadVariableOp2B
dense_202/MatMul/ReadVariableOpdense_202/MatMul/ReadVariableOp2D
 dense_203/BiasAdd/ReadVariableOp dense_203/BiasAdd/ReadVariableOp2B
dense_203/MatMul/ReadVariableOpdense_203/MatMul/ReadVariableOp2D
 dense_204/BiasAdd/ReadVariableOp dense_204/BiasAdd/ReadVariableOp2B
dense_204/MatMul/ReadVariableOpdense_204/MatMul/ReadVariableOp:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
Û
f
H__inference_dropout_56_layer_call_and_return_conditional_losses_13954920

inputs

identity_1N
IdentityIdentityinputs*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ[

Identity_1IdentityIdentity:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*&
_input_shapes
:ÿÿÿÿÿÿÿÿÿ:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs


ø
G__inference_dense_202_layer_call_and_return_conditional_losses_13955291

inputs0
matmul_readvariableop_resource:d-
biasadd_readvariableop_resource:d
identity¢BiasAdd/ReadVariableOp¢MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:d*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdr
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:d*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdP
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿda
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdw
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:ÿÿÿÿÿÿÿÿÿ: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
 
_user_specified_nameinputs
þ

0__inference_sequential_56_layer_call_fn_13955104
input_57
unknown:d
	unknown_0:d
	unknown_1:dd
	unknown_2:d
	unknown_3:d
	unknown_4:
identity¢StatefulPartitionedCall
StatefulPartitionedCallStatefulPartitionedCallinput_57unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ*(
_read_only_resource_inputs

*-
config_proto

CPU

GPU 2J 8 *T
fORM
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955072o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*2
_input_shapes!
:ÿÿÿÿÿÿÿÿÿ: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:Q M
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ
"
_user_specified_name
input_57
Ê	
ø
G__inference_dense_204_layer_call_and_return_conditional_losses_13954966

inputs0
matmul_readvariableop_resource:d-
biasadd_readvariableop_resource:
identity¢BiasAdd/ReadVariableOp¢MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:d*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿr
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿ_
IdentityIdentityBiasAdd:output:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿw
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:ÿÿÿÿÿÿÿÿÿd: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
 
_user_specified_nameinputs


ø
G__inference_dense_203_layer_call_and_return_conditional_losses_13954950

inputs0
matmul_readvariableop_resource:dd-
biasadd_readvariableop_resource:d
identity¢BiasAdd/ReadVariableOp¢MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:dd*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdr
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:d*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdP
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿda
IdentityIdentityRelu:activations:0^NoOp*
T0*'
_output_shapes
:ÿÿÿÿÿÿÿÿÿdw
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:ÿÿÿÿÿÿÿÿÿd: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:ÿÿÿÿÿÿÿÿÿd
 
_user_specified_nameinputs"¿L
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*®
serving_default
=
input_571
serving_default_input_57:0ÿÿÿÿÿÿÿÿÿ=
	dense_2040
StatefulPartitionedCall:0ÿÿÿÿÿÿÿÿÿtensorflow/serving/predict:
è
layer-0
layer_with_weights-0
layer-1
layer_with_weights-1
layer-2
layer_with_weights-2
layer-3
	variables
trainable_variables
regularization_losses
	keras_api
	__call__
*
&call_and_return_all_conditional_losses
_default_save_signature
	optimizer

signatures"
_tf_keras_sequential
¼
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses
_random_generator"
_tf_keras_layer
»
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses

kernel
bias"
_tf_keras_layer
»
	variables
trainable_variables
regularization_losses
 	keras_api
!__call__
*"&call_and_return_all_conditional_losses

#kernel
$bias"
_tf_keras_layer
»
%	variables
&trainable_variables
'regularization_losses
(	keras_api
)__call__
**&call_and_return_all_conditional_losses

+kernel
,bias"
_tf_keras_layer
J
0
1
#2
$3
+4
,5"
trackable_list_wrapper
J
0
1
#2
$3
+4
,5"
trackable_list_wrapper
 "
trackable_list_wrapper
Ê
-non_trainable_variables

.layers
/metrics
0layer_regularization_losses
1layer_metrics
	variables
trainable_variables
regularization_losses
	__call__
_default_save_signature
*
&call_and_return_all_conditional_losses
&
"call_and_return_conditional_losses"
_generic_user_object
ö
2trace_0
3trace_1
4trace_2
5trace_32
0__inference_sequential_56_layer_call_fn_13954988
0__inference_sequential_56_layer_call_fn_13955186
0__inference_sequential_56_layer_call_fn_13955203
0__inference_sequential_56_layer_call_fn_13955104À
·²³
FullArgSpec1
args)&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults
p 

 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 z2trace_0z3trace_1z4trace_2z5trace_3
â
6trace_0
7trace_1
8trace_2
9trace_32÷
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955228
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955252
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955124
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955144À
·²³
FullArgSpec1
args)&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults
p 

 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 z6trace_0z7trace_1z8trace_2z9trace_3
ÏBÌ
#__inference__wrapped_model_13954908input_57"
²
FullArgSpec
args 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
¿
:iter

;beta_1

<beta_2
	=decay
>learning_ratemomp#mq$mr+ms,mtvuvv#vw$vx+vy,vz"
	optimizer
,
?serving_default"
signature_map
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
­
@non_trainable_variables

Alayers
Bmetrics
Clayer_regularization_losses
Dlayer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
Ì
Etrace_0
Ftrace_12
-__inference_dropout_56_layer_call_fn_13955257
-__inference_dropout_56_layer_call_fn_13955262´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 zEtrace_0zFtrace_1

Gtrace_0
Htrace_12Ë
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955267
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955271´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 zGtrace_0zHtrace_1
"
_generic_user_object
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
­
Inon_trainable_variables

Jlayers
Kmetrics
Llayer_regularization_losses
Mlayer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
ð
Ntrace_02Ó
,__inference_dense_202_layer_call_fn_13955280¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 zNtrace_0

Otrace_02î
G__inference_dense_202_layer_call_and_return_conditional_losses_13955291¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 zOtrace_0
": d2dense_202/kernel
:d2dense_202/bias
.
#0
$1"
trackable_list_wrapper
.
#0
$1"
trackable_list_wrapper
 "
trackable_list_wrapper
­
Pnon_trainable_variables

Qlayers
Rmetrics
Slayer_regularization_losses
Tlayer_metrics
	variables
trainable_variables
regularization_losses
!__call__
*"&call_and_return_all_conditional_losses
&""call_and_return_conditional_losses"
_generic_user_object
ð
Utrace_02Ó
,__inference_dense_203_layer_call_fn_13955300¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 zUtrace_0

Vtrace_02î
G__inference_dense_203_layer_call_and_return_conditional_losses_13955311¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 zVtrace_0
": dd2dense_203/kernel
:d2dense_203/bias
.
+0
,1"
trackable_list_wrapper
.
+0
,1"
trackable_list_wrapper
 "
trackable_list_wrapper
­
Wnon_trainable_variables

Xlayers
Ymetrics
Zlayer_regularization_losses
[layer_metrics
%	variables
&trainable_variables
'regularization_losses
)__call__
**&call_and_return_all_conditional_losses
&*"call_and_return_conditional_losses"
_generic_user_object
ð
\trace_02Ó
,__inference_dense_204_layer_call_fn_13955320¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 z\trace_0

]trace_02î
G__inference_dense_204_layer_call_and_return_conditional_losses_13955330¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 z]trace_0
": d2dense_204/kernel
:2dense_204/bias
 "
trackable_list_wrapper
<
0
1
2
3"
trackable_list_wrapper
5
^0
_1
`2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
B
0__inference_sequential_56_layer_call_fn_13954988input_57"À
·²³
FullArgSpec1
args)&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults
p 

 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
Bÿ
0__inference_sequential_56_layer_call_fn_13955186inputs"À
·²³
FullArgSpec1
args)&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults
p 

 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
Bÿ
0__inference_sequential_56_layer_call_fn_13955203inputs"À
·²³
FullArgSpec1
args)&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults
p 

 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
0__inference_sequential_56_layer_call_fn_13955104input_57"À
·²³
FullArgSpec1
args)&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults
p 

 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955228inputs"À
·²³
FullArgSpec1
args)&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults
p 

 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955252inputs"À
·²³
FullArgSpec1
args)&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults
p 

 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955124input_57"À
·²³
FullArgSpec1
args)&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults
p 

 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955144input_57"À
·²³
FullArgSpec1
args)&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults
p 

 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
:	 (2	Adam/iter
: (2Adam/beta_1
: (2Adam/beta_2
: (2
Adam/decay
: (2Adam/learning_rate
ÎBË
&__inference_signature_wrapper_13955169input_57"
²
FullArgSpec
args 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
óBð
-__inference_dropout_56_layer_call_fn_13955257inputs"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
óBð
-__inference_dropout_56_layer_call_fn_13955262inputs"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955267inputs"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
B
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955271inputs"´
«²§
FullArgSpec)
args!
jself
jinputs

jtraining
varargs
 
varkw
 
defaults
p 

kwonlyargs 
kwonlydefaultsª 
annotationsª *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
àBÝ
,__inference_dense_202_layer_call_fn_13955280inputs"¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
ûBø
G__inference_dense_202_layer_call_and_return_conditional_losses_13955291inputs"¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
àBÝ
,__inference_dense_203_layer_call_fn_13955300inputs"¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
ûBø
G__inference_dense_203_layer_call_and_return_conditional_losses_13955311inputs"¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
àBÝ
,__inference_dense_204_layer_call_fn_13955320inputs"¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
ûBø
G__inference_dense_204_layer_call_and_return_conditional_losses_13955330inputs"¢
²
FullArgSpec
args
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs 
kwonlydefaults
 
annotationsª *
 
N
a	variables
b	keras_api
	ctotal
	dcount"
_tf_keras_metric
^
e	variables
f	keras_api
	gtotal
	hcount
i
_fn_kwargs"
_tf_keras_metric
^
j	variables
k	keras_api
	ltotal
	mcount
n
_fn_kwargs"
_tf_keras_metric
.
c0
d1"
trackable_list_wrapper
-
a	variables"
_generic_user_object
:  (2total
:  (2count
.
g0
h1"
trackable_list_wrapper
-
e	variables"
_generic_user_object
:  (2total
:  (2count
 "
trackable_dict_wrapper
.
l0
m1"
trackable_list_wrapper
-
j	variables"
_generic_user_object
:  (2total
:  (2count
 "
trackable_dict_wrapper
':%d2Adam/dense_202/kernel/m
!:d2Adam/dense_202/bias/m
':%dd2Adam/dense_203/kernel/m
!:d2Adam/dense_203/bias/m
':%d2Adam/dense_204/kernel/m
!:2Adam/dense_204/bias/m
':%d2Adam/dense_202/kernel/v
!:d2Adam/dense_202/bias/v
':%dd2Adam/dense_203/kernel/v
!:d2Adam/dense_203/bias/v
':%d2Adam/dense_204/kernel/v
!:2Adam/dense_204/bias/v
#__inference__wrapped_model_13954908r#$+,1¢.
'¢$
"
input_57ÿÿÿÿÿÿÿÿÿ
ª "5ª2
0
	dense_204# 
	dense_204ÿÿÿÿÿÿÿÿÿ§
G__inference_dense_202_layer_call_and_return_conditional_losses_13955291\/¢,
%¢"
 
inputsÿÿÿÿÿÿÿÿÿ
ª "%¢"

0ÿÿÿÿÿÿÿÿÿd
 
,__inference_dense_202_layer_call_fn_13955280O/¢,
%¢"
 
inputsÿÿÿÿÿÿÿÿÿ
ª "ÿÿÿÿÿÿÿÿÿd§
G__inference_dense_203_layer_call_and_return_conditional_losses_13955311\#$/¢,
%¢"
 
inputsÿÿÿÿÿÿÿÿÿd
ª "%¢"

0ÿÿÿÿÿÿÿÿÿd
 
,__inference_dense_203_layer_call_fn_13955300O#$/¢,
%¢"
 
inputsÿÿÿÿÿÿÿÿÿd
ª "ÿÿÿÿÿÿÿÿÿd§
G__inference_dense_204_layer_call_and_return_conditional_losses_13955330\+,/¢,
%¢"
 
inputsÿÿÿÿÿÿÿÿÿd
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 
,__inference_dense_204_layer_call_fn_13955320O+,/¢,
%¢"
 
inputsÿÿÿÿÿÿÿÿÿd
ª "ÿÿÿÿÿÿÿÿÿ¨
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955267\3¢0
)¢&
 
inputsÿÿÿÿÿÿÿÿÿ
p 
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 ¨
H__inference_dropout_56_layer_call_and_return_conditional_losses_13955271\3¢0
)¢&
 
inputsÿÿÿÿÿÿÿÿÿ
p
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 
-__inference_dropout_56_layer_call_fn_13955257O3¢0
)¢&
 
inputsÿÿÿÿÿÿÿÿÿ
p 
ª "ÿÿÿÿÿÿÿÿÿ
-__inference_dropout_56_layer_call_fn_13955262O3¢0
)¢&
 
inputsÿÿÿÿÿÿÿÿÿ
p
ª "ÿÿÿÿÿÿÿÿÿ¹
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955124j#$+,9¢6
/¢,
"
input_57ÿÿÿÿÿÿÿÿÿ
p 

 
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 ¹
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955144j#$+,9¢6
/¢,
"
input_57ÿÿÿÿÿÿÿÿÿ
p

 
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 ·
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955228h#$+,7¢4
-¢*
 
inputsÿÿÿÿÿÿÿÿÿ
p 

 
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 ·
K__inference_sequential_56_layer_call_and_return_conditional_losses_13955252h#$+,7¢4
-¢*
 
inputsÿÿÿÿÿÿÿÿÿ
p

 
ª "%¢"

0ÿÿÿÿÿÿÿÿÿ
 
0__inference_sequential_56_layer_call_fn_13954988]#$+,9¢6
/¢,
"
input_57ÿÿÿÿÿÿÿÿÿ
p 

 
ª "ÿÿÿÿÿÿÿÿÿ
0__inference_sequential_56_layer_call_fn_13955104]#$+,9¢6
/¢,
"
input_57ÿÿÿÿÿÿÿÿÿ
p

 
ª "ÿÿÿÿÿÿÿÿÿ
0__inference_sequential_56_layer_call_fn_13955186[#$+,7¢4
-¢*
 
inputsÿÿÿÿÿÿÿÿÿ
p 

 
ª "ÿÿÿÿÿÿÿÿÿ
0__inference_sequential_56_layer_call_fn_13955203[#$+,7¢4
-¢*
 
inputsÿÿÿÿÿÿÿÿÿ
p

 
ª "ÿÿÿÿÿÿÿÿÿ¨
&__inference_signature_wrapper_13955169~#$+,=¢:
¢ 
3ª0
.
input_57"
input_57ÿÿÿÿÿÿÿÿÿ"5ª2
0
	dense_204# 
	dense_204ÿÿÿÿÿÿÿÿÿ