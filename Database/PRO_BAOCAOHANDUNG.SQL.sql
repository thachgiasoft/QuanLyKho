USE [QLK]
GO
/****** Object:  StoredProcedure [dbo].[SelectBaoCaoHanDung]    Script Date: 07/10/2016 10:39:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--region [dbo].[usp_SelectDmhhHanghoa]

------------------------------------------------------------------------------------------------------------------------
-- Generated By:   nvtho using CodeSmith 6.0.0.0
-- Template:       StoredProcedures.cst
-- Procedure Name: [dbo].[usp_SelectDmhhHanghoa]
-- Date Generated: 22 Tháng Tư 2016
------------------------------------------------------------------------------------------------------------------------

ALTER PROCEDURE [dbo].[SelectBaoCaoHanDung]
	@KH_MAKHO nvarchar(50)
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT
	HH.[HH_MAHANG],
	HH.[HH_TENHANG],
	HH.HH_GIAMUA,
	HH.HH_GIABANLE,
	HH.HH_GIABANSI,
	(SELECT TOP 1 HDNX.[HDNX_HANSUDUNG]
	FROM HD_NHAPXUAT HDNX 
	WHERE 
		HDNX.KH_MAKHO = @KH_MAKHO 
		AND HDNX.HDNX_TRANGTHAI = 1 
		AND HDNX.HH_MAHANG = HH.HH_MAHANG
		ORDER BY HDNX.HDNX_HANSUDUNG DESC) HDNX_HANSUDUNG,
	HH.[HH_KICHHOAT],
	DVT.DVT_TENDONVI
FROM
	[dbo].[DMHH_HANGHOA] HH INNER JOIN DMHH_DONVITINH DVT ON HH.DVT_MADONVI = DVT.DVT_MADONVI
WHERE HH.HH_KICHHOAT = 1
GROUP BY 
	HH.[HH_MAHANG],
	HH.[HH_TENHANG],
	HH.HH_GIAMUA,
	HH.HH_GIABANLE,
	HH.HH_GIABANSI,
	--HDNX.[HDNX_HANSUDUNG],
	HH.[HH_KICHHOAT],
	DVT.DVT_TENDONVI

--endregion

