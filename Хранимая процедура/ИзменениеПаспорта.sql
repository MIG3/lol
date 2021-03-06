/*    ==Параметры сценариев==

    Версия исходного сервера : SQL Server 2016 (13.0.4206)
    Выпуск исходного ядра СУБД : Выпуск Microsoft SQL Server Enterprise Edition
    Тип исходного ядра СУБД : Изолированный SQL Server

    Версия целевого сервера : SQL Server 2017
    Выпуск целевого ядра СУБД : Выпуск Microsoft SQL Server Standard Edition
    Тип целевого ядра СУБД : Изолированный SQL Server
*/

USE [ИС ЕРЗ]
GO
/****** Object:  StoredProcedure [dbo].[Изменение_паспорта]    Script Date: 19.01.2018 23:09:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Автор: Губин Максим, группа 8о-408Б
-- =============================================
ALTER PROCEDURE [dbo].[Изменение_паспорта] 
(
	@flag int,
	@Имя char(20),
	@Фамилия char(20),
	@Отчество char(20),
	@НовИмя char(20),
	@НовФамилия char(20),
	@НовОтчество char(20),
	@Серия_паспорта char(4),
	@Номер_паспорта char(6)

)
AS
BEGIN
DECLARE @id  int;
	BEGIN
		SET @id = (SELECT  ID_ЗЛ FROM [Персоналные данные] AS PD
							WHERE PD.Фамилия like '%' + RTRIM(@Фамилия) + '%'
							AND PD.Имя like '%' + RTRIM(@Имя) + '%'
							AND PD.Отчество like '%' + RTRIM(@Отчество));
		if (@flag = 0)
			BEGIN
				UPDATE dbo.[Персоналные данные] 
				SET Имя = @НовИмя, Фамилия = @НовФамилия, Отчество = @НовОтчество 
				WHERE ID_ЗЛ = @id
			END
		else if (@flag = 1)
			BEGIN
				UPDATE dbo.[Персоналные данные] 
				SET Серия = @Серия_паспорта, Номер = @Номер_паспорта 
				WHERE ID_ЗЛ = @id
			END
	END
END
