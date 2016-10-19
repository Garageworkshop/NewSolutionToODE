%// Firstly you need to define a function `f` in terms of `x` and `y`. 
syms x y e;
f = x-y^2;


yOfx = sym('y(x)');
f_yOfx = subs(f, y, yOfx);

df = diff(f_yOfx, x);

syms Dy;
df2 = subs(df, diff(yOfx, x), Dy);
% a=subs(f_yOfx,[x,y],[2,3])
% b=subs(df2,Dy,a)
ycor=2;
z=0;

for i= 0:0.1:2
    first=subs(f_yOfx,[x,y],[i,ycor]);
    second=subs(df2,[Dy,x,y],[first,i,ycor]);

    r=abs(((1+first^2)^(3/2))/second);
    if r>100000000
        r=100000000
    end
    d=solve((x-i)^2+((-1/first)*(x-i))^2-r^2,x);
    if double(second) == 0
        b=i
    else
        if double(second)<0
        b=d(double(d)>i);
    else 
        b=d(double(d)<i);
    end
    end
    ycorcircle=(-1/first)*(b-i)+ycor;

    xCenter = real(double(b));
    yCenter = real(double(ycorcircle));
    centers = [xCenter yCenter];

    % Fix the axis limits.
    xlim([0 4]);

    % Set the axis aspect ratio to 1:1.
    axis square
%     viscircles(centers,double(r));
    hold on;
    f=solve((i+0.5-xCenter)^2+(e-yCenter)^2-r^2,e);
    if double(second) == 0
        ycor = max(f)
    else
        if double(second)>0
        ycor=min(f);
    else 
        ycor=max(f);
    end
    end
    plot(i,double(ycor))    
end