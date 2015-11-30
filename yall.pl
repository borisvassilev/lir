%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  Copyright (c) 2015, Paulo Moura <pmoura@logtalk.org>
%  All rights reserved.
%  
%  Redistribution and use in source and binary forms, with or without
%  modification, are permitted provided that the following conditions
%  are met:
%
%  1. Redistributions of source code must retain the above copyright
%  notice, this list of conditions and the following disclaimer.
%
%  2. Redistributions in binary form must reproduce the above copyright
%  notice, this list of conditions and the following disclaimer in the
%  documentation and/or other materials provided with the distribution.
%
%  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
%  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
%  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
%  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
%  COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
%  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
%  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
%  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
%  AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
%  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
%  THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
%  DAMAGE.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/** <module> Logtalk lambda expressions

This module implementing Logtalk's lambda expressions syntax.
Development of this module was sponsored by Kyndi, Inc.

Lambda expressions use the syntax {...}/[...]>>Goal.

The {...} optional part is used for lambda-free variables. The
order of variables doesn't matter hence the {...} set notation.

The [...] optional part lists lambda parameters. Here order of
variables matters hence the list notation.

As (/)/2 and (>>)/2 are standard operators, no new operators are
added by this library. An advantage of this syntax is that we can
simply unify a lambda expression with Free/Parameters>>Lambda to
access each of its components. Spaces in the lambda expression are
not a problem although the goal may need to be written between ()'s.

Use of the apply_macros library in conjunction with this library is
advised for practical performance when using lambda expressions.

The module name, yall, stands for yet another lambda library.

@tbd	Extend optimization support
@author	Paulo Moura
*/


:- module(yall, [
	(>>)/2, (>>)/3, (>>)/4, (>>)/5, (>>)/6, (>>)/7, (>>)/8, (>>)/9, 
	(/)/2, (/)/3, (/)/4, (/)/5, (/)/6, (/)/7, (/)/8, (/)/9
]).

:- use_module(library(error)).

:- meta_predicate
	'>>'(?, 0),
	'>>'(?, :, ?),
	'>>'(?, :, ?, ?),
	'>>'(?, :, ?, ?, ?),
	'>>'(?, :, ?, ?, ?, ?),
	'>>'(?, :, ?, ?, ?, ?, ?),
	'>>'(?, :, ?, ?, ?, ?, ?, ?),
	'>>'(?, :, ?, ?, ?, ?, ?, ?, ?).

:- meta_predicate
	'/'(?, 0),
	'/'(?, 1, ?),
	'/'(?, 2, ?, ?),
	'/'(?, 3, ?, ?, ?),
	'/'(?, 4, ?, ?, ?, ?),
	'/'(?, 5, ?, ?, ?, ?, ?),
	'/'(?, 6, ?, ?, ?, ?, ?, ?),
	'/'(?, 7, ?, ?, ?, ?, ?, ?, ?).


'>>'(Free/Parameters, Lambda) :-
	!,
	copy_term_nat(Free+Lambda, Free+LambdaCopy),
	(	Parameters == [] ->
		call(LambdaCopy)
	;	domain_error(lambda_parameters,Free/Parameters>>Lambda)
	).

'>>'(Parameters, Lambda) :-
	copy_term_nat(Lambda, LambdaCopy),
	(	Parameters == [] ->
		call(LambdaCopy)
	;	domain_error(lambda_parameters,Parameters>>Lambda)
	).

'>>'(Free/Parameters, Lambda, Arg1) :-
	!,
	copy_term_nat(Free/Parameters>>Lambda, Free/ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1], ExtraArgs, Free/Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Parameters, Lambda, Arg1) :-
	copy_term_nat(Parameters>>Lambda, ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1], ExtraArgs, Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Free/Parameters, Lambda, Arg1, Arg2) :-
	!,
	copy_term_nat(Free/Parameters>>Lambda, Free/ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2], ExtraArgs, Free/Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Parameters, Lambda, Arg1, Arg2) :-
	copy_term_nat(Parameters>>Lambda, ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2], ExtraArgs, Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Free/Parameters, Lambda, Arg1, Arg2, Arg3) :-
	!,
	copy_term_nat(Free/Parameters>>Lambda, Free/ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2, Arg3], ExtraArgs, Free/Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Parameters, Lambda, Arg1, Arg2, Arg3) :-
	copy_term_nat(Parameters>>Lambda, ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2, Arg3], ExtraArgs, Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Free/Parameters, Lambda, Arg1, Arg2, Arg3, Arg4) :-
	!,
	copy_term_nat(Free/Parameters>>Lambda, Free/ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2, Arg3, Arg4], ExtraArgs, Free/Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Parameters, Lambda, Arg1, Arg2, Arg3, Arg4) :-
	copy_term_nat(Parameters>>Lambda, ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2, Arg3, Arg4], ExtraArgs, Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Free/Parameters, Lambda, Arg1, Arg2, Arg3, Arg4, Arg5) :-
	!,
	copy_term_nat(Free/Parameters>>Lambda, Free/ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2, Arg3, Arg4, Arg5], ExtraArgs, Free/Parameters),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Parameters, Lambda, Arg1, Arg2, Arg3, Arg4, Arg5) :-
	copy_term_nat(Parameters>>Lambda, ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2, Arg3, Arg4, Arg5], ExtraArgs, Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Free/Parameters, Lambda, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) :-
	!,
	copy_term_nat(Free/Parameters>>Lambda, Free/ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2, Arg3, Arg4, Arg5, Arg6], ExtraArgs, Free/Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Parameters, Lambda, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) :-
	copy_term_nat(Parameters>>Lambda, ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2, Arg3, Arg4, Arg5, Arg6], ExtraArgs, Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Free/Parameters, Lambda, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) :-
	!,
	copy_term_nat(Free/Parameters>>Lambda, Free/ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7], ExtraArgs, Free/Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'>>'(Parameters, Lambda, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) :-
	copy_term_nat(Parameters>>Lambda, ParametersCopy>>LambdaCopy),
	unify_lambda_parameters(ParametersCopy, [Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7], ExtraArgs, Parameters>>Lambda),
	Goal =.. [call, LambdaCopy| ExtraArgs],
	call(Goal).

'/'(Free, Lambda) :-
	copy_term_nat(Free+Lambda, Free+LambdaCopy),
	call(LambdaCopy).

'/'(Free, Lambda, Arg1) :-
	copy_term_nat(Free+Lambda, Free+LambdaCopy),
	call(LambdaCopy, Arg1).

'/'(Free, Lambda, Arg1, Arg2) :-
	copy_term_nat(Free+Lambda, Free+LambdaCopy),
	call(LambdaCopy, Arg1, Arg2).

'/'(Free, Lambda, Arg1, Arg2, Arg3) :-
	copy_term_nat(Free+Lambda, Free+LambdaCopy),
	call(LambdaCopy, Arg1, Arg2, Arg3).

'/'(Free, Lambda, Arg1, Arg2, Arg3, Arg4) :-
	copy_term_nat(Free+Lambda, Free+LambdaCopy),
	call(LambdaCopy, Arg1, Arg2, Arg3, Arg4).

'/'(Free, Lambda, Arg1, Arg2, Arg3, Arg4, Arg5) :-
	copy_term_nat(Free+Lambda, Free+LambdaCopy),
	call(LambdaCopy, Arg1, Arg2, Arg3, Arg4, Arg5).

'/'(Free, Lambda, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) :-
	copy_term_nat(Free+Lambda, Free+LambdaCopy),
	call(LambdaCopy, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6).

'/'(Free, Lambda, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) :-
	copy_term_nat(Free+Lambda, Free+LambdaCopy),
	call(LambdaCopy, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7).


unify_lambda_parameters(Parameters, Arguments, ExtraArguments, Lambda) :-
	must_be(list, Parameters),
	unify_lambda_parameters_(Parameters, Arguments, ExtraArguments, Lambda).

unify_lambda_parameters_([], ExtraArguments, ExtraArguments, _) :-
	!.
unify_lambda_parameters_([Parameter| Parameters], [Argument| Arguments], ExtraArguments, Lambda) :-
	!,
	Parameter = Argument,
	unify_lambda_parameters_(Parameters, Arguments, ExtraArguments, Lambda).
unify_lambda_parameters_(_, _, _, Lambda) :-
	domain_error(lambda_parameters, Lambda).


:- dynamic system:goal_expansion/2.
:- multifile system:goal_expansion/2.

system:goal_expansion(Goal, Head) :-
	Goal =.. ['>>', {Free}/Parameters, Lambda| ExtraArgs],
	callable(Lambda),
	Parameters = ExtraArgs,
	variant_sha1_nat({Free}/Parameters>>Lambda, Functor0),
	atom_concat('__aux_yall_', Functor0, Functor),
	conjunction_to_list(Free, FreeList),
	append(FreeList, Parameters, Args),
	Head =.. [Functor| Args],
	compile_aux_clause_if_new(Head, Lambda).

system:goal_expansion(Goal, Head) :-
	Goal =.. ['>>', Parameters, Lambda| ExtraArgs],
	Parameters \= _/_,
	callable(Lambda),
	Parameters = ExtraArgs,
	variant_sha1_nat(Parameters>>Lambda, Functor0),
	atom_concat('__aux_yall_', Functor0, Functor),
	Head =.. [Functor| Parameters],
	compile_aux_clause_if_new(Head, Lambda).

system:goal_expansion(Goal, Head) :-
	Goal =.. ['/', {Free}, Closure| ExtraArgs],
	callable(Closure),
	variant_sha1_nat({Free}/Closure, Functor0),
	atom_concat('__aux_yall_', Functor0, Functor),
	conjunction_to_list(Free, FreeList),
	append(FreeList, ExtraArgs, Args),
	Head =.. [Functor| Args],
	Closure =.. [ClosureFunctor| ClosureArgs],
	append(ClosureArgs, ExtraArgs, LambdaArgs),
	Lambda =.. [ClosureFunctor| LambdaArgs],
	compile_aux_clause_if_new(Head, Lambda).

variant_sha1_nat(Term, Hash) :-
	copy_term_nat(Term, Copy),
	variant_sha1(Copy, Hash).

conjunction_to_list(Term, [Term]) :-
	var(Term),
	!.
conjunction_to_list((Term, Conjunction), [Term| Terms]) :-
	!,
	conjunction_to_list(Conjunction, Terms).
conjunction_to_list(Term, [Term]).

compile_aux_clause_if_new(Head, Lambda) :-
	prolog_load_context(module, Context),
	(	predicate_property(Context:Head, _) ->
		true
	;	compile_aux_clauses([(Head :- Lambda)])
	).

lambda_calls({Free}/_>>Lambda, N, Goal) :-
	!,
	callable(Lambda),
	term_variables(Free, Vars),
	length(Vars, Arity0),
	functor(Lambda, Functor, _),
	Arity is Arity0 + N,
	functor(Goal, Functor, Arity).
lambda_calls(_>>Lambda, _, Goal) :-
	callable(Lambda),
	functor(Lambda, Functor, Arity),
	functor(Goal, Functor, Arity).
lambda_calls(_/Lambda, N, Goal) :-
	callable(Lambda),
	functor(Lambda, Functor, Arity0),
	Arity is Arity0 + N,
	functor(Goal, Functor, Arity).
