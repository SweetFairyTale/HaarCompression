%对高频信号做阈值限定，绝对值小于thr的全部置为0
function [ch,cv,cd]=threshold(h,v,d,thr,r,c)
count=0;
for i=1:r
    for j=1:c
        if(abs(h(i,j))<thr)
            h(i,j)=0;
            count=count+1;
        end
        if(abs(v(i,j))<thr)
            v(i,j)=0;
            count=count+1;
        end
        if(abs(d(i,j))<thr)
            d(i,j)=0;
            count=count+1;
        end
        ch=h;
        cv=v;
        cd=d;
    end
end
disp(count);