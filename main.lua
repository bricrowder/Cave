

function love.load()
    --the map of cells
    map = {}
    map.width = 64              -- number of cells in width
    map.height = 64             -- number of cells in height
    map.cell_size = 8           -- size of the cell in pixels
    map.start_fill = 50         -- the chance that a cell will be initially filled
    map.cells = {}

    --randomly fill in the map based on the map.start_fill chance
    i, j = 1
    for i = 1, map.width do
        map.cells[i] = {}
        for j = 1, map.height do
            -- make the border a 1
            if i == 1 or i == map.width or j == 1 or j == map.height then 
                map.cells[i][j] = 1
            else
                -- make the insides random
                if love.math.random(1,100) <= map.start_fill then
                    map.cells[i][j] = 1
                else 
                    map.cells[i][j] = 0
                end
            end
        end
    end
end

function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "p" then
        map_pass()
    end
end

function map_pass()
    -- this takes the map.cells table and checks neighbors to see if the cell should stay the same or change
    -- going to only make the insides 
    temp_map = map.cells

    i, j = 1
    for i = 2, map.width - 1 do
        for j = 2, map.height - 1 do
            --store the cells to check against
            temp_cells = {
                map.cells[i-1][j-1],
                map.cells[i][j-1],
                map.cells[i+1][j-1],
                map.cells[i-1][j],
                map.cells[i+1][j],
                map.cells[i-1][j+1],
                map.cells[i][j+1],
                map.cells[i+1][j+1],
            }
            
            --how many walls exist around
            wallcounter = 0
            for k = 1, #temp_cells do
                if temp_cells[k] == 1 then wallcounter = wallcounter + 1 end
            end

            --now check
            if map.cells[i][j] == 1 then
                if wallcounter >= 4 then
                    temp_map[i][j] = 1
                else    
                    temp_map[i][j] = 0
                end
            else
                if wallcounter >= 6 then
                    temp_map[i][j] = 1
                else    
                    temp_map[i][j] = 0
                end                
            end
        end
    end

    --pass is done, overwrite the map
    map.cells = temp_map

end

function love.update(dt)

end


function love.draw()
    i, j = 1

    for i = 1, map.width do
        for j = 1, map.height do
            if map.cells[i][j] == 1 then love.graphics.rectangle("fill", i*map.cell_size, j*map.cell_size, map.cell_size, map.cell_size) end
        end
    end

end
