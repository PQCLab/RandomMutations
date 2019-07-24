rm_init;
rmparams.n_pop = 100;
s = rand(4,1) + 1i*rand(4,1);
s = s/norm(s);
[result, result_p] = OptimizeRM( @(p)m_quantum_example(s,p), 8);

U1 = param_U_2(result_p(1:4));
U2 = param_U_2(result_p(5:8));
U = kron(U1,U2);

result_state = U*s;
disp(result_state);
disp(result);