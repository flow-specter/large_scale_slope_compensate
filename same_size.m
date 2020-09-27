function [new_img1,new_img2] = same_size(img1,img2)
%UNTITLED3 此处显示有关此函数的摘要
%   以左上角为对其点，进行samesize
[r1,c1]=size(img1); 
[r2,c2]=size(img2); 


if r1>=r2
    new_r1_range=[1,r2];
    new_r2_range=[1,r2]; %r2不变
else
    new_r1_range=[1,r1];%r1不变    
    new_r2_range=[1,r1]; 
end

if c1>=c2
    new_c1_range=[1,c2];
    new_c2_range=[1,c2]; %c2不变
else
    new_c1_range=[1,c1];%c1不变    
    new_c2_range=[1,c1]; 
end

new_img1=img1(new_r1_range(1):new_r1_range(2),new_c1_range(1):new_c1_range(2));
new_img2=img2(new_r2_range(1):new_r2_range(2),new_c2_range(1):new_c2_range(2));

%   以影像中心点为对齐点，进行samesize

% [r1,c1]=size(img1); r1_length=(r1-1)/2;c1_length=(c1-1)/2;
% [r2,c2]=size(img2); r2_length=(r2-1)/2;c2_length=(c2-1)/2;
% 
% center_r1=ceil(r1/2);
% center_c1=ceil(c1/2);
% 
% center_r2=ceil(r2/2);
% center_c2=ceil(c2/2);
% 
% if r1>=r2
%     new_r1_range=[center_r1-r2_length,center_r1+r2_length];
%     new_r2_range=[1,r2]; %r2不变
% else
%     new_r1_range=[1,r1];%r1不变    
%     new_r2_range=[center_r2-r1_length,center_r2+r1_length]; 
% end
% 
% if c1>=c2
%     new_c1_range=[center_c1-c2_length,center_c1+c2_length];
%     new_c2_range=[1,c2]; %c2不变
% else
%     new_c1_range=[1,c1];%c1不变    
%     new_c2_range=[center_c2-c1_length,center_c2+c1_length]; 
% end
% 
% new_img1=img1(new_r1_range(1):new_r1_range(2),new_c1_range(1):new_c1_range(2));
% new_img2=img2(new_r2_range(1):new_r2_range(2),new_c2_range(1):new_c2_range(2));

end