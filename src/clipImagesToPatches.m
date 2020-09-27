function [ output_args ] = clipImagesToPatches( Z, width_patch,height_patch,...
                            overlap_x, overlap_y, nodata_value )
%clipImagesToPatches 裁剪图像块为不存在NaN值的patch
%   para[in] Z: 需要裁剪的影像，默认为三通道。
%   para[in] width_patch： patch的宽度。
%   para[in] height_patch： patch的高度。
%   para[in] overlap_x： patch在x方向的重叠像素。
%   para[in] overlap_y： patch在y方向的重叠像素。
%   para[in] nodata_value： 需要舍弃的nodata值，e.g.， nodata_value =NaN;


[r,c]=size(Z(:,:,1)); % 取第一张即可    
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
        %判断是否有无效值
        crop=img(y:y+height_patch,x:x+width_patch,:);
        [num_of_novalue,novalue_index] = check_if_nodata(crop,nodata_value);            
        if num_of_novalue~=0 %如果有无效值，则得到其最大的x坐标，并以此为新的x坐标，向右进行crop              
            [max_x_novalue] = get_nodata_max_x(crop,novalue_index);               
            if max_x_novalue < x+ width_patch %判断重新裁剪的patch是否在范围内，并且对重新裁剪的crop影像判断是否仍有无效值
            rect=[max_x_novalue,y,width_patch,height_patch];
            tmp_crop=imcrop(img,rect);
            [num_of_novalue,~] = check_if_nodata(tmp_crop,nodata_value);  
            if num_of_novalue==0 %如果新的patch没有nodata，则可以对其进行裁剪，否则进下一个循环
            num_of_patch  = num_of_patch + 1;                                            
%           save_uint8_patch(tmp_crop,num_of_patch,savepath_dem,savepath_dom_l,savepath_dom_r)
            crop_all = [crop_all;tmp_crop];
            end
            end
        else  % 没有无效点的情况
            rect=[x,y,width_patch,height_patch];
            tmp_crop=imcrop(img,rect);
            num_of_patch  = num_of_patch + 1;
            crop_all = [crop_all;tmp_crop];
        end        
    end
end 
end

