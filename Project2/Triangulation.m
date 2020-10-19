%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      To perform Triangulation and compute the estimated 3D position
%      given two 2D points and camera infos.
%
% Input Variables:
%      Pu1/2      Input two 2D points
%      K1/2       3*3 triangular matrices corresponding to the cameras
%      R1/2       3*3 rotation matrices
%      C1/2       3*1 camera coordinates
%
% Returned Results:
%      Pw         Output computed 3D coordinates
%
% Processing Flow:
%      1. Derive both vectors(rays) from inputs
%      2. Compute the third vector and construct the 3 linear equations
%      3. Using solve() to solve the equations and obtain the scale factors
%          a,b and d
%      4. Using the unit vectors, scale factors and camera cords to compute Pw
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Pw = Triangulation(Pu1,Pu2,K1,K2,R1,R2,C1,C2)
    V1 = R1'*inv(K1)*Pu1;
    uV1 = V1/sum(abs(V1));
 
    V2 = R2'*inv(K2)*Pu2;
    uV2 = V2/sum(abs(V2));
    
    uV3 = cross(uV1,uV2)/sum(abs(cross(uV1,uV2)));
    
    syms a b d
    E1 = a*uV1-b*uV2+d*uV3;  E2=C2-C1;
    eqn(1) = E1(1) == E2(1); eqn(2) = E1(2) == E2(2); eqn(3) = E1(3) == E2(3);
    S = solve(eqn,[a b d]);
    P1 = double(S.a)*uV1+C1; P2 = double(S.b)*uV2+C2;
    Pw = (P1+P2)/2;

end