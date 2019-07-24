function [ res ] = m_quantum_example( s, p )
%QUANTUM_EXAMPLE Summary of this function goes here
%   Detailed explanation goes here
U1 = param_U_2(p(1:4));
U2 = param_U_2(p(5:8));
U = kron(U1,U2);
s2 = U*s;

res = -abs(s2(1)*s2(2));

end

