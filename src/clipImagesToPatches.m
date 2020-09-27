function [ output_args ] = clipImagesToPatches( Z, width_patch,height_patch,...
                            overlap_x, overlap_y, nodata_value )
%clipImagesToPatches �ü�ͼ���Ϊ������NaNֵ��patch
%   para[in] Z: ��Ҫ�ü���Ӱ��Ĭ��Ϊ��ͨ����
%   para[in] width_patch�� patch�Ŀ�ȡ�
%   para[in] height_patch�� patch�ĸ߶ȡ�
%   para[in] overlap_x�� patch��x������ص����ء�
%   para[in] overlap_y�� patch��y������ص����ء�
%   para[in] nodata_value�� ��Ҫ������nodataֵ��e.g.�� nodata_value =NaN;


[r,c]=size(Z(:,:,1)); % ȡ��һ�ż���    
img = zeros(r,c,3);
img(:,:,1) = Z;
img(:,:,2) = X;
img(:,:,3) = Z_infer_x;

step_x=width_patch-overlap_x;
step_y=height_patch-overlap_y;
num_of_patch=0;

crop_all = [];
for x=1:step_x:(c-width_patch)
    for y=1:step_y:(r-height_patch)     
        %�ж��Ƿ�����Чֵ
        crop=img(y:y+height_patch,x:x+width_patch,:);
        [num_of_novalue,novalue_index] = check_if_nodata(crop,nodata_value);            
        if num_of_novalue~=0 %�������Чֵ����õ�������x���꣬���Դ�Ϊ�µ�x���꣬���ҽ���crop              
            [max_x_novalue] = get_nodata_max_x(crop,novalue_index);               
            if max_x_novalue < x+ width_patch %�ж����²ü���patch�Ƿ��ڷ�Χ�ڣ����Ҷ����²ü���cropӰ���ж��Ƿ�������Чֵ
            rect=[max_x_novalue,y,width_patch,height_patch];
            tmp_crop=imcrop(img,rect);
            [num_of_novalue,~] = check_if_nodata(tmp_crop,nodata_value);  
            if num_of_novalue==0 %����µ�patchû��nodata������Զ�����вü����������һ��ѭ��
            num_of_patch  = num_of_patch + 1;                                            
%           save_uint8_patch(tmp_crop,num_of_patch,savepath_dem,savepath_dom_l,savepath_dom_r)
            crop_all = [crop_all;tmp_crop];
            end
            end
        else  % û����Ч������
            rect=[x,y,width_patch,height_patch];
            tmp_crop=imcrop(img,rect);
            num_of_patch  = num_of_patch + 1;
            crop_all = [crop_all;tmp_crop];
        end        
    end
end 
end

