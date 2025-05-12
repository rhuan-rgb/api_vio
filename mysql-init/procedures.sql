delimiter //

create procedure registrar_compra(
    in p_id_usuario int,
    in p_id_ingresso int,
    in p_quantidade int
)
begin
    declare v_id_compra int;

    insert into compra (data_compra, fk_id_usuario) 
    values (now(), p_id_usuario);

    set v_id_compra = last_insert_id();

    insert into ingresso_compra (fk_id_compra, fk_id_ingresso, quantidade)
    values (v_id_compra, p_id_ingresso, p_quantidade);

end; //

delimiter ;


delimiter //
   create procedure total_ingressos_usuario (
      in p_id_usuario int,
      in p_id_ingresso int,
      in p_id_quantidade int
)
begin
   declare v_id_compra int;
   --Criar registro na tabela 'compra'
   insert into compra(data_compra, fk_id_usuario)
   values (now(), p_id_usuario);
   
   -- Obter o id da compra recém-criada
   set v_id_compra = last_insert_id();

   -- Registrar os ingressos comprados
   insert into ingresso_compra (fk_id_compra, fk_id_ingresso, quantidade)
   values (v_id_compra, p_id_ingresso, p_quantidade);

end; //

delimiter ;     





delimiter //
   create procedure total_ingressos_usuario (
      in p_id_usuario int,
      out p_total_ingressos int
)  
begin
   -- Inicializar o valor de sáida
   set p_total_ingressos = 0;

   -- consultar e somar todos os ingressos comprados pelo usuário
    select coalesce(sum(ic.quantidade), 0)
    into p_total_ingressos
    from ingresso_compra ic
    join compra c on ic.fk_id_compra = c.id_compra
    where c.fk_id_usuario = p_id_usuario;
end; //
delimiter ;

set @total = 0;

call total_ingressos_usuario(2, @total);




delimiter //

create procedure registrar_presenca(
    in p_id_compra int,
    in p_id_evento int
)
begin
    -- Registrar presenca
    insert into presenca (data_hora_checkin, fk_id_evento, fk_id_compra)
    values (now(), p_id_evento, p_id_compra);
end //

delimiter ;

-- procedure para resumo do usuário
delimiter $$

create procedure resumo_usuario(in pid int)
begin
   declare nome varchar(100);
   declare email varchar(100);
   declare totalrs decimal(10,2);
   declare faixa varchar(20);

   -- busca o nome e o email do usuário
   select u.name, u.email into nome, email 
   from usuario u
   where u.id_usuario = pid; 

   -- chamada das funções específicas já criadas
   set totalrs = calcula_total_gasto(pid);
   set faixa = buscar_faixa_etaria_usuario(pid);

   -- xibe os dados formatados
   select nome as nome_usuario,
            email as email_usuario,
            totalrs as total_gasto,
            faixa as faixa_etaria;
end; $$

delimiter ;





