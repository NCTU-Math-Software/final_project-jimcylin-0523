function rat()
%x=[46 162],y=[43,159] r=116

    
    colormap(colorcube)%讀圖片檔及固定顏色
    circle=imread('circle.png');
    mouse=imread('mouse.png');
    plus=imread('plus.png');
    wrong=imread('wrong.png');
    heart=imread('heart.png');
    Ready=imread('Ready.png');
    Go=imread('Go.png');
    thanks=imread('thanks.png');
    map = zeros(600,600,3,'uint8');%開地圖
    map=[circle,circle,circle;circle,circle,circle;circle,circle,circle];
   
    %設定參數們
    tt=0;
    last=0;
    made=0;
    score=0;
    
    %READY　ＧＯ
    image(Ready)
    pause(1.2)
    image(Go)
    pause(1)
    
    while(tt<=20)%遊戲開始 總共玩20次
        title(['Score: ',num2str(score),'  Times: ',num2str(tt),'/',num2str(20)]);%記分板和你玩了幾次
        ax=axes();
        hole=round(rand(1)*8+1);%生成洞
        
        if(hole==last)%避免洞重複
            hole=mod(hole,9)+1;
        end
        
        for ii=1:200%老鼠出沒
            for jj=1:200
                map(floor((hole-1)/3)*200+jj,mod(hole-1,3)*200+ii,:)=mouse(jj,ii,:);
            end
        end
        
        chance=round(rand(1)*4+1);%愛心出現機率1/5，若骰到5<或連續答對3次，就出愛心
        if(chance==5||made==3)
             hole2=round(rand(1)*8+1);%愛心洞
             if(hole2==hole)%避免洞重複
                 hole2=mod(hole,9)+1;
             end
             
             for ii=1:200%heart出沒
                 for jj=1:200
                    map(floor((hole2-1)/3)*200+jj,mod(hole2-1,3)*200+ii,:)=heart(jj,ii,:);
                 end
             end
             
        end
        image(map)%把刷新後的地圖印出來
        drawnow;
        pause(0.7);%給你0.7秒按
        
        action='down'; %點擊滑鼠 這是參考chiuyuju同學的
        switch (action)
            case 'down'
                set(gcf,'WindowButtonDownFcn','mouse01 down')
                coo=ax.CurrentPoint(1,1:2);
                set(gcf,'WindowButtonUpFcn','mouse01 up')
        end
        x=coo(1);
        y=coo(2);
                
        x1=mod(hole-1,3)*200+46;%算出洞的座標範圍
        y1=floor((hole-1)/3)*200+43;
        
        if((x-x1)<=116&&(x-x1)>=0&&(y-y1)<=116&&(y-y1)>=0)%判斷有沒有打中
            for ii=1:400%right
                for jj=1:400%勾勾出現
                    if(plus(ii,jj)~=uint8(255))
                        map(100+ii,100+jj,:)=plus(ii,jj,:);
                    end
                end
            end
            made=made+1;%算連對的次數
            score=score+5;%對了加5分
            
        else
            for ii=1:400%wrong
                for jj=1:400%叉叉出現
                    if(wrong(ii,jj)~=uint8(255))
                        map(100+ii,100+jj,:)=wrong(ii,jj,:);
                    end
                end
            end
            score=score-3;%錯了扣3分
            made=0;
        end
        image(map)%把勾勾差差畫出來
        
        pause(0.5)
        map=[circle,circle,circle;circle,circle,circle;circle,circle,circle];%重置地圖
        tt=tt+1;
        last=hole;%記住上個洞
        clf('reset')%把東西擦乾淨
    end
    title(['Score;',num2str(score)]);%記分板
    ax=axes();%結為畫面
    image(thanks)
end

        
        
    