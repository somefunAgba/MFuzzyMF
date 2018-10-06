function y = mfmf(x,params,option)
%MFMF M-shaped fuzzy curve membership function.
%   MFMF(X, PARAMS, OPTION) returns a matrix which is the M-shaped
%   membership function evaluated at X. 
%
%   PARAMS = PARAMS = [X0,X1,..,X4]  or [X0,X1,..,X7] 
%   is a 5-element or an 8-element vector that determines the break points 
%   of this membership function.
%   A more special case is the triggered Pulse-Membership Function
%
%   OPTION = 1, 1.2, 1.3
%   At n = 0 or 2;
%   When Xn < Xn+1, MMF is a smooth transition from 0 (at Xn) to 1 (at Xn+1).
%   else when Xn >= X(n+1),MMF becomes a step function
%   jumping from 0 to 1 at (Xn+1+Xn)/2.
%   At n = 1 or 3;
%   When Xn < X(n+1), MMF is a smooth transition from 1 (at Xn) to 0 (at Xn+1).
%   else when Xn >= X(n+1),MMF becomes a reverse-step function
%
%   OPTION = 2, 2.2, 2.3
%   At n = 0 or 4;
%   When Xn < Xn+1, MMF is a smooth transition from 0 (at Xn) to 1 (at Xn+1).
%   else when Xn >= X(n+1),MMF becomes a step function
%   jumping from 0 to 1 at (Xn+1+Xn)/2.
%   At n = 2 or 6;
%   When Xn < X(n+1), MMF is a smooth transition from 1 (at Xn) to 0 (at Xn+1).
%   else when Xn >= X(n+1),MMF becomes a reverse-step function
%   jumping from 1 to 0 at (Xn+1+Xn)/2.
%   At n = 1;
%   MMF is a constant 1 (at Xn) to (at Xn+1).
%   At n = 3;
%   MMF is a constant 0 (at Xn) to (at Xn+1).
%
%   For example:
%     x = 0:0.1:10;
%     mh =figure();
%     %% type-1
%     % We can write the letter M in 5!=120 different ways
%     subplot(651); ax11 = plot(x, mfmf(x, [2.4 3 3.5 5.5 8]), '-.k');
%     ax11.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(652); ax12 = plot(x, mfmf(x, [3 2 4 6 5]), '-.k');
%     ax12.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(653); ax13 = plot(x, mfmf(x, [0 3 6 8 10]), '-.k');
%     ax13.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(654); ax14 = plot(x, mfmf(x, [2 3 4 5 6]), '-.k');
%     ax14.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(655); ax15 = plot(x, mfmf(x, [3 2 5 4 6]), '-.k');
%     ax15.LineWidth = 1.5;
%     grid on; grid minor;
%     %% type-1.2
%     % We can write the letter M in 5!=120 different ways
%     subplot(656); ax21 = plot(x, mfmf(x, [2.4 3 3.5 5.5 8],1.2), '-.k');
%     ax21.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(657); ax22 = plot(x, mfmf(x, [3 2 4 6 5], 1.2), '-.k');
%     ax22.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(658); ax23 = plot(x, mfmf(x, [0 3 6 8 10], 1.2), '-.k');
%     ax23.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(659); ax24 = plot(x, mfmf(x, [2 3 4 5 6], 1.2), '-.k');
%     ax24.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,10); ax25 = plot(x, mfmf(x, [3 2 5 4 6], 1.2), '-.k');
%     ax25.LineWidth = 1.5;
%     grid on; grid minor;
%     %% type-1.3
%     % We can write the letter M in 5!=120 different ways
%     subplot(6,5,11); ax31 = plot(x, mfmf(x, [2.4 3 3.5 5.5 8],1.3), '-.k');
%     ax31.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,12); ax32 = plot(x, mfmf(x, [3 2 4 6 5], 1.3), '-.k');
%     ax32.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,13); ax33 = plot(x, mfmf(x, [0 3 6 8 10], 1.3), '-.k');
%     ax33.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,14); ax34 = plot(x, mfmf(x, [2 3 4 5 6], 1.3), '-.k');
%     ax34.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,15); ax35 = plot(x, mfmf(x, [3 2 5 4 6], 1.3), '-.k');
%     ax35.LineWidth = 1.5;
%     grid on; grid minor;
%     %% type-2
%     % We can spawn the letter M in 8!=40,320 different ways
%     subplot(6,5,16); ax41 = plot(x, mfmf(x, [2 2.4 3 3.5 5 5.5 6 8], 2), '--.k');
%     ax41.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,17); ax42 = plot(x, mfmf(x, [4 4.2 4.6 5 5.2 5.6 5.8 6], 2), '--.k');
%     ax42.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,18); ax43 = plot(x, mfmf(x, [0 3.5 5 6 7 8.3 9 10], 2), '--.k');
%     ax43.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,19); ax44 = plot(x, mfmf(x, [1 2 3 4 6 7 8 9], 2), '--.k');
%     ax44.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,20); ax45 = plot(x, mfmf(x, [1 7 2 6 4 5 8 9], 2), '--.k');
%     ax45.LineWidth = 1.5;
%     grid on; grid minor;
%     %% type-2.2
%     % We can spawn the letter M in 8!=40,320 different ways
%     subplot(6,5,21); ax51 = plot(x, mfmf(x, [2 2.4 3 3.5 5 5.5 6 8], 2.2), '--.k');
%     ax51.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,22); ax52 = plot(x, mfmf(x, [4 4.2 4.6 5 5.2 5.6 5.8 6], 2.2), '--.k');
%     ax52.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,23); ax53 = plot(x, mfmf(x, [0 3.5 5 6 7 8.3 9 10], 2.2), '--.k');
%     ax53.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,24); ax54 = plot(x, mfmf(x, [1 2 3 4 6 7 8 9], 2.2), '--.k');
%     ax54.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,25); ax55 = plot(x, mfmf(x, [1 7 2 6 4 5 8 9], 2.2), '--.k');
%     ax55.LineWidth = 1.5;
%     grid on; grid minor;
%     %% type-2.3
%     % We can spawn the letter M in 8!=40,320 different ways
%     subplot(6,5,26); ax61 = plot(x, mfmf(x, [2 2.4 3 3.5 5 5.5 6 8], 2.3), '--.k');
%     ax61.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,27); ax62 = plot(x, mfmf(x, [4 4.2 4.6 5 5.2 5.6 5.8 6], 2.3), '--.k');
%     ax62.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,28); ax63 = plot(x, mfmf(x, [0 3.5 5 6 7 8.3 9 10], 2.3), '--.k');
%     ax63.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,29); ax64 = plot(x, mfmf(x, [1 2 3 4 6 7 8 9], 2.3), '--.k');
%     ax64.LineWidth = 1.5;
%     grid on; grid minor;
%     subplot(6,5,30); ax65 = plot(x, mfmf(x, [1 7 2 6 4 5 8 9], 2.3), '--.k');
%     ax65.LineWidth = 1.5;
%     grid on; grid minor;
%     set(mh, 'name', 'M-MF', 'numbertitle', 'off');
% 
%   Author: Somefun Oluwasegun
%   Email: oasomefun@ieee.org
%   (c) 2018
%   Dept: EEE/CPE, FUTA


if nargin < 3
    option = 1;
end

a = cast(params(1),'like',x);
b = cast(params(2),'like',x);
c = cast(params(3),'like',x);
d = cast(params(4),'like',x);
e = cast(params(5),'like',x);
if length(params) > 5
    f = cast(params(6),'like',x);
    g = cast(params(7),'like',x);
    h = cast(params(8),'like',x);
end

y = zeros(size(x));

% if x1 >= x0
%     y = cast((x<=(x0+x1)/2),'like',x);
%     return;
% end
if option == 1
    % a - b
    if a < b
        id = find( (a <= x) & (x <= 0.5*(a + b)));
        if ~isempty(id)
            y(id) = 2*((x(id)-a)/(b-a)).^2;
        end
        id = find( (0.5*(a+b) <= x) & (x <= b));
        if ~isempty(id)
            y(id) = 1 - 2*((x(id)-b)/(b-a)).^2;
        end
    else
        id = find( (a < x) & (x <= b) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= a+b/2),'like',x);
        end
    end
    % b - c
    if b < c
        id = find( (b < x) & (x <= 0.5*(b + c)));
        if ~isempty(id)
            y(id) = 1 - 2*((x(id)-b)/(c-b)).^2;
        end
        id = find( (0.5*(b+c) < x) & (x <= c));
        if ~isempty(id)
            y(id) = 2*((x(id)-c)/(c-b)).^2;
        end
    else
        id = find( (b < x) & (x <= c) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= b+c/2),'like',x);
        end
    end
    % c - d
    if c < d
        id = find( (c <= x) & (x <= 0.5*(c + d)));
        if ~isempty(id)
            y(id) = 2*((x(id)-c)/(d-c)).^2;
        end
        id = find( (0.5*(c+d) <= x) & (x <= d));
        if ~isempty(id)
            y(id) = 1 - 2*((x(id)-d)/(d-c)).^2;
        end
    else
        id = find( (c < x) & (x <= d) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= c+d/2),'like',x);
        end
    end
    % d - e
    if d < e
        id = find( (d < x) & (x <= 0.5*(d + e)));
        if ~isempty(id)
            y(id) = 1 - 2*((x(id)-d)/(e-d)).^2;
        end
        id = find( (0.5*(d+e) < x) & (x <= e));
        if ~isempty(id)
            y(id) = 2*((x(id)-e)/(e-d)).^2;
        end
    else
        id = find( (d < x) & (x <= e) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= d+e/2),'like',x);
        end
    end
end
if option == 1.2
    % a - b
    if a < b
        id = find( (a <= x) & (x <= b));
        if ~isempty(id)
            y(id) = ((x(id)-a)/(b-a)).^2;
        end
    else
        id = find( (a < x) & (x <= b) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= a+b/2),'like',x);
        end
    end
    % b - c
    if b < c
        id = find( (b < x) & (x <= c));
        if ~isempty(id)
            y(id) = ((c-x(id))/(c-b)).^2;
        end
    else
        id = find( (b < x) & (x <= c) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= b+c/2),'like',x);
        end
    end
    % c - d
    if c < d
        id = find( (c <= x) & (x <=  d));
        if ~isempty(id)
            y(id) = ((x(id)-c)/(d-c)).^2;
        end
    else
        id = find( (c < x) & (x <= d) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= c+d/2),'like',x);
        end
    end
    % d - e
    if d < e
        id = find( (d < x) & (x <= e));
        if ~isempty(id)
            y(id) = ((e - x(id))/(e-d)).^2;
        end
    else
        id = find( (d < x) & (x <= e) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= d+e/2),'like',x);
        end
    end
end
if option == 1.3
    % a - b
    if a < b
        id = find( (a <= x) & (x <= b));
        if ~isempty(id)
            y(id) = ((x(id)-a)/(b-a));
        end
    else
        id = find( (a < x) & (x <= b) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= a+b/2),'like',x);
        end
    end
    % b - c
    if b < c
        id = find( (b < x) & (x <= c));
        if ~isempty(id)
            y(id) = ((c-x(id))/(c-b));
        end
    else
        id = find( (b < x) & (x <= c) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= b+c/2),'like',x);
        end
    end
    % c - d
    if c < d
        id = find( (c <= x) & (x <=  d));
        if ~isempty(id)
            y(id) = ((x(id)-c)/(d-c));
        end
    else
        id = find( (c < x) & (x <= d) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= c+d/2),'like',x);
        end
    end
    % d - e
    if d < e
        id = find( (d < x) & (x <= e));
        if ~isempty(id)
            y(id) = ((e - x(id))/(e-d));
        end
    else
        id = find( (d < x) & (x <= e) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= d+e/2),'like',x);
        end
    end
end

if option == 2
    % a - b
    if a < b
        id = find( (a <= x) & (x <= 0.5*(a + b)));
        if ~isempty(id)
            y(id) = 0.5*((x(id)-a)/(b-a)).^2;
        end
        id = find( (0.5*(a+b) <= x) & (x <= b));
        if ~isempty(id)
            y(id) = 1 - 0.5*((x(id)-b)/(b-a)).^2;
        end
    else
        id = find( (a < x) & (x <= b) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= a+b/2),'like',x);
        end
    end
    % b - c
    id = find( (b < x) & (x <= c) );
    if ~isempty(id)
        y(id) = 1;
    end
    if c < d
        % c - d
        id = find( (c < x) & (x <= 0.5*(c + d)));
        if ~isempty(id)
            y(id) = 1 - 0.5*((x(id)-c)/(d-c)).^2;
        end
        id = find( (0.5*(c+d) < x) & (x <= d));
        if ~isempty(id)
            y(id) = 0.5*((x(id)-d)/(d-c)).^2;
        end
    else
        id = find( (c < x) & (x <= d) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= c+d/2),'like',x);
        end
    end
    % d - e
    id = find( (d < x) & (x <= e) );
    if ~isempty(id)
        y(id) = 0;
    end
    % e - f
    if e < f
        id = find( (e < x) & (x <= 0.5*(e + f)));
        if ~isempty(id)
            y(id) = 0.5*((x(id)-e)/(f-e)).^2;
        end
        id = find( (0.5*(e+f) < x) & (x <= f));
        if ~isempty(id)
            y(id) = 1 - 0.5*((x(id)-f)/(f-e)).^2;
        end
    else
        id = find( (e < x) & (x <= f) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= e+f/2),'like',x);
        end
    end
    % f - g
    id = find( (f < x) & (x <= g) );
    if ~isempty(id)
        y(id) = 1;
    end
    % g - h
    if g < h
        id = find( (g < x) & (x <= 0.5*(g + h)));
        if ~isempty(id)
            y(id) = 1 - 0.5*((x(id)-g)/(h-g)).^2;
        end
        id = find( (0.5*(g+h) < x) & (x <= h));
        if ~isempty(id)
            y(id) = 0.5*((x(id)-h)/(h-g)).^2;
        end
    else
        id = find( (g < x) & (x <= h) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= g+h/2),'like',x);
        end
    end
end
if option == 2.2
    % a - b
    if a < b
        id = find( (a <= x) & (x <= 0.5*(a + b)));
        if ~isempty(id)
            y(id) = 2*((x(id)-a)/(b-a)).^2;
        end
        id = find( (0.5*(a+b) <= x) & (x <= b));
        if ~isempty(id)
            y(id) = 1 - 2*((x(id)-b)/(b-a)).^2;
        end
    else
        id = find( (a < x) & (x <= b) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= a+b/2),'like',x);
        end
    end
    % b - c
    id = find( (b < x) & (x <= c) );
    if ~isempty(id)
        y(id) = 1;
    end
    if c < d
        % c - d
        id = find( (c < x) & (x <= 0.5*(c + d)));
        if ~isempty(id)
            y(id) = 1 - 2*((x(id)-c)/(d-c)).^2;
        end
        id = find( (0.5*(c+d) < x) & (x <= d));
        if ~isempty(id)
            y(id) = 2*((x(id)-d)/(d-c)).^2;
        end
    else
        id = find( (c < x) & (x <= d) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= c+d/2),'like',x);
        end
    end
    % d - e
    id = find( (d < x) & (x <= e) );
    if ~isempty(id)
        y(id) = 0;
    end
    % e - f
    if e < f
        id = find( (e < x) & (x <= 0.5*(e + f)));
        if ~isempty(id)
            y(id) = 2*((x(id)-e)/(f-e)).^2;
        end
        id = find( (0.5*(e+f) < x) & (x <= f));
        if ~isempty(id)
            y(id) = 1 - 2*((x(id)-f)/(f-e)).^2;
        end
    else
        id = find( (e < x) & (x <= f) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= e+f/2),'like',x);
        end
    end
    % f - g
    id = find( (f < x) & (x <= g) );
    if ~isempty(id)
        y(id) = 1;
    end
    % g - h
    if g < h
        id = find( (g < x) & (x <= 0.5*(g + h)));
        if ~isempty(id)
            y(id) = 1 - 2*((x(id)-g)/(h-g)).^2;
        end
        id = find( (0.5*(g+h) < x) & (x <= h));
        if ~isempty(id)
            y(id) = 2*((x(id)-h)/(h-g)).^2;
        end
    else
        id = find( (g < x) & (x <= h) );
        for idx = min(id):max(id)
            y(idx) = cast((x(idx) <= g+h/2),'like',x);
        end
    end
end
if option == 2.3
    
    id = find( (a <= x) & (x <= b) );
    if ~isempty(id)
        y(id) =(x(id)-a)/(b-a);
    end
    % b - c, f - g
    id = find( ((b < x) & (x <= c)) | ((f < x) & (x <= g)) );
    if ~isempty(id)
        y(id) = 1;
    end
    % c - d
    id = find( (c < x) & (x <= d));
    if ~isempty(id)
        y(id) = (d -x(id))/(d-c);
    end
    % d - e
    id = find( (d < x) & (x <= e) );
    if ~isempty(id)
        y(id) = 0;
    end
    % e - f
    id = find( (e < x) & (x <= f) );
    if ~isempty(id)
        y(id) = (x(id)-e)/(f-e);
    end
    
    % g - h
    id = find( (g < x) & (x <= h ) );
    if ~isempty(id)
        y(id) = (h -x(id))/(h-g);
    end
end
    
end
