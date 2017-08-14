 % MATLAB script
 % y = sample(x) returns y sampled from distribution x
 X_today = [ 0 1 0 ]'; % Cloudy
 T = [ 8 2 0 ; 4 4 2 ; 2 6 2 ]' / 10;
 %data = ['suny';'cloudy';'rainy'];
% celldata = cellstr(data);
 x =  T * X_today;
 X_tomorrow = sample( x );
 if ( X_tomorrow(1) == 1 )
 disp( 'sunny' );
 elseif ( X_tomorrow(2) == 1 )
 disp( 'cloudy' );
 elseif ( X_tomorrow(3) == 1 )
 disp( 'rainy' );
 end
