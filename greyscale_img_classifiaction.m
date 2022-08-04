clear;
clc;
close all;


%loading data
[training_data_1,m1]=process_data_greyscale('C:\Users\chirag\Desktop\matlabfiles\Assignment-2\training\Defective',20,20,1);
y1=ones(m1,1);
x11=size(y1);
x1=length(y1);
[training_data_2,m2]=process_data_greyscale('C:\Users\chirag\Desktop\matlabfiles\Assignment-2\training\Non-Defective',20,20,1);
y2=zeros(m2,1);
x22=size(y2);
x2=length(y2);

[training_data_3,m3]=process_data_greyscale('C:\Users\chirag\Desktop\def',20,20,1);
[training_data_4,m4]=process_data_greyscale('C:\Users\chirag\Desktop\notdef',20,20,1);
y3=ones(m3,1);
y4=zeros(m4,1);
training_data_cv=[training_data_3;training_data_4];
[m_cv,n_cv]=size(training_data_cv);
X_cv=[ones(m_cv,1) training_data_cv];
y_cv=[y3;y4]; 

%merging dataset
training_data=[training_data_1;training_data_2];  %420*1200
y=[y1;y2]; 
x3=size(y);   %420*1
x33=length(y);  %420
x4=size(training_data);%420*1200
x44=length(training_data);  %1200
X=training_data;
[m,n]=size(X);

%compute cost and gradient descent
X=[ones(m,1) X];
theta=zeros(n+1,1);

lambda=[0.01 0.02 0.1 0.2 1 10];
J=zeros(length(lambda),1);


for i=1:1:length(lambda)
    initial_theta=zeros(n+1,1);
    options = optimset('GradObj', 'on', 'MaxIter', 17);
    [theta, cost] = fminunc(@(t)(costFunctionreg(t, X, y,lambda(i))), initial_theta, options);
    J(i)=costFunction(theta, X_cv, y_cv);
end



[c,d]=find(J==min(J));
final_lambda=lambda(c);
fprintf('lambda determined is %f \n', final_lambda);

[theta, cost] = ...
	fminunc(@(t)(costFunctionreg(t, X, y,final_lambda)), initial_theta, options);

% Print theta to screen

fprintf('theta: \n');
fprintf(' %f \n', theta);

%prediction

[test_data_1 s1]=process_data_greyscale('C:\Users\chirag\Desktop\matlabfiles\Assignment-2\test\defective',20,20,1);
y_act1=ones(s1,1);
test_data_2=[ones(s1,1) test_data_1]
for i=1:1:s1
   a1(i)=predict(theta,test_data_2(i,:))
end
[test_data_3 s2]=process_data_greyscale('C:\Users\chirag\Desktop\matlabfiles\Assignment-2\test\not defective',20,20,1);
Y_act2=zeros(s2,1);

test_data_4=[ones(s2,1) test_data_3]
for i=1:1:s2
   b2(i)=predict(theta,test_data_4(i,:))
end
fprintf('defective percentage \n');
sum(a1)
fprintf('not defective percentage: \n',1-sum(b2)/1000);
sum(b2)


% Confusion Matrix
tp=0;
fp=0;
for i=1:1:s1
    if(a1(i)==1)
        tp=tp+1;
    end
    if(a1(i)==0)
        fp=fp+1;
    end
end

tn=0;
fn=0;
for i=1:1:s2
    if(b2(i)==0)
        tn=tn+1;
    end
    if(b2(i)==1)
        fn=fn+1;
    end
end    

fprintf('Printing confusion matrix\n');
confusion_matrix=[tp fn;fp tn]

fprintf('Accuracy is:\n')
accuracy=((tp+tn)/(tp+fn+fp+tn))*100

fprintf('precision is:\n');
precision=tp/(tp+fp)%fraction of defective chips

fprintf('recall is:\n');
recall=tp/(tp+fn)

fprintf('F1 score is:')
f1_score=2*(precision*recall)/(precision+recall)




