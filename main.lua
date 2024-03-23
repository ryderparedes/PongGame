SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720

p1y = 50       
p2y = 630       

p1_score = 0
p2_score = 0

xBALL_POSITION = SCREEN_WIDTH / 2 - 6
yBALL_POSITION = SCREEN_WIDTH / 2 - 6

speedCounter = 25

storeSPEED = 0

xSPEED = 300
ySPEED = 300

gameStart = false

timer = 0

alpha = 0
player_end = 1

local game = {
    state = {
        menu = false,
        playing = false,
        ending = false,
    }
}


function love.load()
    love.window.setTitle("Pong")
    
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.update(dt)
    function love.keypressed(key)
        if key == 'escape' then
            love.event.quit()
        end        
    end

    if game.state["playing"] then
        --Timer
        timer = timer + dt

        --Ball Speed
        if gameStart then
            xBALL_POSITION = xBALL_POSITION + xSPEED * dt
            yBALL_POSITION = yBALL_POSITION + ySPEED * dt
        end

        --Wall Detection
        if yBALL_POSITION < 0 or yBALL_POSITION > SCREEN_HEIGHT then
            ySPEED = -ySPEED
        end

        --Collision
        --Center Paddle Part
        if (yBALL_POSITION < p1y + 30 and yBALL_POSITION > p1y) and (xBALL_POSITION > 25 and xBALL_POSITION < 30) then
            if ySPEED ~= 0 then
                storeSPEED = ySPEED
            end

            xSPEED = xSPEED * -1
            ySPEED = 0
        end

        if (yBALL_POSITION < p2y + 30 and yBALL_POSITION > p2y) and (xBALL_POSITION > 1250 and xBALL_POSITION < 1255) then
            if ySPEED ~= 0 then
                storeSPEED = ySPEED
            end

            xSPEED = xSPEED * -1
            ySPEED = 0

        end

        --Right Paddle Part
        if (yBALL_POSITION < p1y and yBALL_POSITION > p1y - 40) and (xBALL_POSITION > 25 and xBALL_POSITION < 30) then
            if xSPEED < 0 then
                xSPEED = xSPEED + -speedCounter
            elseif xSPEED > 0 then
                xSPEED = xSPEED + speedCounter
            end

            if(ySPEED == 0) then
                ySPEED = storeSPEED
            end
            
            xSPEED = xSPEED * -1
            ySPEED = (math.abs(ySPEED) * -1) + -speedCounter
            storeSPEED = ySPEED
        end

        if (yBALL_POSITION < p2y and yBALL_POSITION > p2y - 40) and (xBALL_POSITION > 1250 and xBALL_POSITION < 1255) then
            if xSPEED < 0 then
                xSPEED = xSPEED + -speedCounter
            elseif xSPEED > 0 then
                xSPEED = xSPEED + speedCounter
            end

            if(ySPEED == 0) then
                ySPEED = storeSPEED
            end

            xSPEED = xSPEED * -1
            ySPEED = (math.abs(ySPEED) * -1) + -speedCounter
            storeSPEED = ySPEED
        end

        --Left Paddle Part
        if (yBALL_POSITION < p1y + 70 and yBALL_POSITION > p1y + 30) and (xBALL_POSITION > 25 and xBALL_POSITION < 30) then
            if xSPEED < 0 then
                xSPEED = xSPEED + -speedCounter
            elseif xSPEED > 0 then
                xSPEED = xSPEED + speedCounter
            end

            if(ySPEED == 0) then
                ySPEED = storeSPEED
            end
            
            xSPEED = xSPEED * -1
            ySPEED = math.abs(ySPEED) + speedCounter
            storeSPEED = ySPEED
        
        end

        if (yBALL_POSITION < p2y + 70 and yBALL_POSITION > p2y + 30) and (xBALL_POSITION > 1250 and xBALL_POSITION < 1255) then
            if xSPEED < 0 then
                xSPEED = xSPEED + -speedCounter
            elseif xSPEED > 0 then
                xSPEED = xSPEED + speedCounter
            end

            if(ySPEED == 0) then
                ySPEED = storeSPEED
            end
            
            xSPEED = xSPEED * -1
            ySPEED = math.abs(ySPEED) + speedCounter
            storeSPEED = ySPEED

        end

        --Score and Reset
        if xBALL_POSITION < 0 then
            timer = 0
            alpha = 0
            p2_score = p2_score + 1
            gameStart = false
            xBALL_POSITION = SCREEN_WIDTH / 2 - 6
            yBALL_POSITION = love.math.random(0, 700)

            storeSPEED = 0

            xSPEED = -300
            
            if ySPEED > 0 then
                ySPEED = -300
            else 
                ySPEED = 300
            end

        elseif xBALL_POSITION > 1280 then
            timer = 0
            alpha = 0
            p1_score = p1_score + 1
            gameStart = false
            xBALL_POSITION = SCREEN_WIDTH / 2 - 6
            yBALL_POSITION = love.math.random(0, 700)

            storeSPEED = 0

            xSPEED = 300
            
            if ySPEED > 0 then
                ySPEED = -300
            else 
                ySPEED = 300
            end

        end

        if timer > 1 then
            alpha = 1
            gameStart = true
        end

        --Game End
        if p1_score == 10 then
        
        elseif p2_score == 10 then

        end

        --Player 1
        if love.keyboard.isDown('w') then
            if(p1y > 50) then
                p1y = p1y - 3
            end
        elseif love.keyboard.isDown('s') then
            if(p1y < 640) then
                p1y = p1y + 3
            end
        end 

        --Player 2 
        if love.keyboard.isDown('up') then
            if(p2y > 50) then
                p2y = p2y - 3
            end
        elseif love.keyboard.isDown('down') then
            if(p2y < 640) then
                p2y = p2y + 3
            end
        end 
    end
end

function love.draw()
    if game.state["playing"] then
        love.graphics.setColor(255, 255, 255, player_end)
        --love.graphics.print('Pong', SCREEN_WIDTH / 2 - 6, SCREEN_HEIGHT / 2 - 325, 0, 2, 2)
        love.graphics.print(p2_score, SCREEN_WIDTH / 2 + 200, SCREEN_HEIGHT / 2 - 325, 0, 2, 2)
        love.graphics.print(p1_score, SCREEN_WIDTH / 2 - 200, SCREEN_HEIGHT / 2 - 325, 0, 2, 2)

        paddle1_center = love.graphics.rectangle("fill", 10, p1y, 15, 30) --Player 1 Paddle
        paddle2_center = love.graphics.rectangle("fill", 1255, p2y , 15, 30) --Player 2 Paddle

        paddle1_right = love.graphics.rectangle("fill", 10, p1y - 40, 15, 40)
        paddle1_left = love.graphics.rectangle("fill", 10, p1y + 30, 15, 40)

        paddle2_right = love.graphics.rectangle("fill", 1255, p2y - 40, 15, 40)
        paddle2_left = love.graphics.rectangle("fill", 1255, p2y + 30, 15, 40)

        love.graphics.line(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, SCREEN_WIDTH)

        love.graphics.setColor(255,255,255,alpha)
        love.graphics.circle("fill", xBALL_POSITION, yBALL_POSITION, 5) 
    end
end
    
