-- ip Rhuan: 10.89.240.65
-- functions

delimiter $$
create function total_ingressos_vendidos(id_evento int)
returns int
NOT DETERMINISTIC
READS SQL
begin
    declare total int;
        select sum(ic.quantidade) into total
        from ingresso_compra ic
        join ingresso i on ic.fk_id_ingresso = i.id_ingresso
        join evento e on i.fk_id_evento = e.id_evento
        where e.id_evento = id_evento;

    return ifnull(total, 0);
    
end; $$

delimiter ;

delimiter $$

create function renda_total_evento(id_evento int)
returns decimal(10,2)
NOT DETERMINISTIC
READS SQL DATA
begin
    DECLARE total DECIMAL(10,2);

    select sum(i.preco * ic.quantidade) into total
    from compra c
    join ingresso_compra ic on c.id_compra = ic.fk_id_compra
    join ingresso i on i.id_ingresso = ic.fk_id_ingresso
    WHERE i.fk_id_evento = id_evento;

    RETURN IFNULL(total, 0);
end; $$

delimiter ;


-- procedures
delimiter $$
create procedure resumo_evento(IN id_evento INT)
begin 
    SELECT 
        e.nome, 
        e.data_hora as data, 
        total_ingressos_vendidos(id_evento) as "ingressos vendidos", 
        renda_total_evento(id_evento) as "renda total"
    from evento e
    where e.id_evento = id_evento;
end; $$

delimiter ;


    