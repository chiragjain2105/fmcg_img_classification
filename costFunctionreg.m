function [J,grad]=costFunctionreg(theta,X,Y,lambda)
m=length(Y);
h=sigmoid(X*theta);
J=(1/m)*sum((-Y.*log(h))-(1-Y).*log(1-h))+(lambda/(2*m))*sum(theta(2:end).^2);


 for j=1:1:length(theta)
     sum1=0;
     if j==1
     for i=1:1:m
         h(i)=sigmoid(theta'*X(i,:)');
         sum1=sum1+(h(i)-Y(i))*X(i,j);
     end
     grad(j)=sum1/m;
     
     else
          for i=1:1:m
            h(i)=sigmoid(theta'*X(i,:)');
            sum1=sum1+(h(i)-Y(i))*X(i,j);
          end
     end
     grad(j)=(sum1/m)+(lambda/m)*theta(j);
 end
end