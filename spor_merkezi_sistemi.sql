CREATE DATABASE Spor_Merkezi;
use Spor_Merkezi;
CREATE TABLE uye
(
    uye_id          INT     AUTO_INCREMENT,
    UYE_AD          VARCHAR(80)     NOT NULL,
    UYE_SOYAD       VARCHAR(80)     NOT NULL,
    UYE_TELEFON     VARCHAR(11)     NOT NULL,
    UYE_MAIL        VARCHAR(250)    NOT NULL,
    UYE_ADRES       VARCHAR(250)    NOT NULL,
    UYE_KanGrubu    VARCHAR(5)    NOT NULL,

    UYE_CINSIYET    VARCHAR(50) DEFAULT 'Bilinmiyor',
    
PRIMARY KEY(uye_id)
);		



CREATE TABLE egitmenler
(
    egitmen_egitmen_id      INT             AUTO_INCREMENT PRIMARY KEY,
    egitmen_TC              VARCHAR(11)     NOT NULL,
    egitmen_EGITMEN_ADI     VARCHAR(250)    NOT NULL,
    egitmen_EGITMEN_SOYAD   VARCHAR(250)    NOT NULL,
    egitmen_CINSIYET        VARCHAR(64)     NOT NULL,
    UYE_ID                  INT,           
    egitmen_MAAS            FLOAT           NOT NULL,
    egitmen_TELEFON         VARCHAR(11)     NOT NULL,
    egitmen_MAIL            VARCHAR(250)    NOT NULL,
    egitmen_ADRES           VARCHAR(250)    NOT NULL,
    FOREIGN KEY(UYE_ID) REFERENCES uye(UYE_ID)
);


	
CREATE TABLE Spor_Dali
(
    Spor_Dali_ID    INT             AUTO_INCREMENT PRIMARY KEY,
    Spor_Dali_Adi   VARCHAR(250)    NOT NULL,
    

    KEY(satis_id),
    FOREIGN KEY(musteri_id) REFERENCES abc_musteriler(musteri_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(urun_id) REFERENCES abc_urunler(urun_id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE egitmen_Spor_Dali(
    Egitmen_Spor_ID INT AUTO_INCREMENT PRIMARY KEY,
    Spor_Dali_ID INT,  
    egitmen_egitmen_id INT, 
    
    FOREIGN KEY(egitmen_egitmen_id) REFERENCES egitmenler(egitmen_egitmen_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Spor_Dali_ID) REFERENCES spor_dali(Spor_Dali_ID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE ekipman(
    ekipman_ID INT AUTO_INCREMENT PRIMARY KEY,
    durumu varchar(10) NOT NULL,
    ekipman_Adi varchar(50) NOT NULL,
    Spor_Dali_ID INT,  
    
    FOREIGN KEY(Spor_Dali_ID) REFERENCES spor_dali(Spor_Dali_ID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Odeme (     uye_ID    INT,     odeme_ID  INT AUTO_INCREMENT PRIMARY KEY, FOREIGN KEY (uye_ID) REFERENCES uye(uye_ID) );
DELIMITER $$
CREATE PROCEDURE sporM_uyelerinHepsi()
BEGIN
    SELECT 
        uye_ıd     as ID,
        uye_telefon      as Adı,
        uye_Soyadı   as Soyadı,
        uye_Telefon     as Telefon, 
	 uye_Mail  as Mail,
        uye_ID   as Adres,
 uye_KanGrubu as KanGrubu
    FROM abc_musteriler;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sporM_uyeEkle (
    ID      varchar(64) ,
    Adı      varchar(64) ,
    Soyadı     varchar(64) ,
    Telefon     varchar(25) ,
    Mail    varchar(250),
    Adres     varchar(250),
    KanGrubu varchar(4)	
)
BEGIN
    INSERT INTO uye
    VALUES (ID, Adı, Soyadı, Telefon, Mail, Adres, KanGrubu);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sporM_uyeGuncelle (
    ID      varchar(64) ,
    Adı      varchar(64) ,
    Soyadı     varchar(64) ,
    Telefon     varchar(25) ,
    Mail    varchar(250),
    Adres     varchar(250),
    KanGrubu varchar(4)	)
BEGIN
    UPDATE uye
    SET 
        uye_ıd      = ad,
        uye_Soyadı   = soy,
        uye_telefon      = tel,
        uye_Mail  = mail,
        musteri_adres   = adr,
 	  uye_ID= ID,
	  uye_KanGrubu = KanGrubu
WHERE 
        musteri_id      = id;
END $$      
DELIMITER;





DELIMITER $$
CREATE PROCEDURE sporM_UyeSil (
    ID      varchar(64) 
)
BEGIN
    DELETE FROM uye
    WHERE   musteri_id = id;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sporM_UyeBul (
    filtre  VARCHAR(32)
)
BEGIN
    SELECT 
        uye_id     AS ID,
        uye_AD     AS Adı,
        uye_Soyad   AS Soyadı,
        uye_Telefon AS Telefon, 
        uye_Mail   AS Mail,
        uye_Adres  AS Adres,
        uye_KanGrubu AS KanGrubu,
        uye_Cinsiyet AS Cinsiyet
    FROM uye
    WHERE 
        uye_id      LIKE CONCAT('%', filtre, '%') OR
        uye_AD      LIKE CONCAT('%', filtre, '%') OR
        uye_Soyad   LIKE CONCAT('%', filtre, '%') OR
        uye_Telefon LIKE CONCAT('%', filtre, '%') OR
        uye_Mail    LIKE CONCAT('%', filtre, '%') OR
        uye_Adres   LIKE CONCAT('%', filtre, '%') OR
        uye_Cinsiyet LIKE CONCAT('%', filtre, '%') OR
        uye_KanGrubu LIKE CONCAT('%', filtre, '%');
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE SporM_EgitmenSil (
    p_EgitmenID    INT
)
BEGIN
    DELETE FROM egitmenler
    WHERE
        egitmen_egitmen_id = p_EgitmenID;
END $$
DELIMITER ;








DELIMITER $$
	CREATE PROCEDURE SporM_EgitmenEkle (
		p_TC        VARCHAR(11),
		p_Adı       VARCHAR(250),
		p_Soyadı    VARCHAR(250),
		p_Cinsiyet  VARCHAR(64),
		p_UyeID     INT,
		p_Maas      FLOAT,
		p_Telefon   VARCHAR(11),
		p_Mail      VARCHAR(250),
		p_Adres     VARCHAR(250)
	)
	BEGIN
		INSERT INTO Eğitmenler (egitmen_TC, egitmen_EGITMEN_ADI,egitmen_EGITMEN_SOYAD, egitmen_CINSIYET, UYE_ID, egitmen_MAAS , egitmen_TELEFON, egitmen_MAIL, egitmen_ADRES)
		VALUES (p_TC, p_Adı, p_Soyadı, p_Cinsiyet, p_UyeID, p_Maas, p_Telefon, p_Mail, p_Adres);
	END $$
	DELIMITER ;

DELIMITER $$
CREATE PROCEDURE SporM_EgitmenGuncelle (
    p_EgitmenID    INT,
    p_TC           VARCHAR(11),
    p_Adı          VARCHAR(250),
    p_Soyadı       VARCHAR(250),
    p_Cinsiyet     VARCHAR(64),
    p_UyeID        INT,
    p_Maas         FLOAT,
    p_Telefon      VARCHAR(11),
    p_Mail         VARCHAR(250),
    p_Adres        VARCHAR(250)
)
BEGIN
    UPDATE egitmenler
    SET 
        egitmen_TC              = p_TC,
        egitmen_EGITMEN_ADI     = p_Adı,
        egitmen_EGITMEN_SOYAD   = p_Soyadı,
        egitmen_CINSIYET        = p_Cinsiyet,
        UYE_ID                  = p_UyeID,
        egitmen_MAAS            = p_Maas,
        egitmen_TELEFON         = p_Telefon,
        egitmen_MAIL            = p_Mail,
        egitmen_ADRES           = p_Adres
    WHERE
        egitmen_egitmen_id      = p_EgitmenID;
END $$
DELIMITER ;









DELIMITER $$

CREATE PROCEDURE SporM_EgitmenlerinHepsi ()
BEGIN
    SELECT
        egitmen_egitmen_id AS EgitmenID,
        egitmen_TC AS EgitmenTC,
        egitmen_EGITMEN_ADI AS EgitmenAdi,
        egitmen_EGITMEN_SOYAD AS EgitmenSoyadi,
        egitmen_CINSIYET AS EgitmenCinsiyet,
        UYE_ID AS UyeID,
        egitmen_MAAS AS EgitmenMaas,
        egitmen_TELEFON AS EgitmenTelefon,
        egitmen_MAIL AS EgitmenMail,
        egitmen_ADRES AS EgitmenAdres
    FROM
        egitmenler;
END $$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE SporM_OdemeEkle (
    p_UyeID     INT,
    p_Tarih     DATETIME,
    p_Miktar    DECIMAL(10, 2),
    p_Aciklama  VARCHAR(255)
)
BEGIN
    INSERT INTO Odeme (uye_ID, tarih, miktar, aciklama)
    VALUES (p_UyeID, p_Tarih, p_Miktar, p_Aciklama);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE SporM_OdemeGuncelle (
    p_OdemeID   INT,
    p_UyeID     INT,
    p_Tarih     DATETIME,
    p_Miktar    DECIMAL(10, 2),
    p_Aciklama  VARCHAR(255)
)
BEGIN
    UPDATE Odeme
    SET
        uye_ID = p_UyeID,
        tarih = p_Tarih,
        miktar = p_Miktar,
        aciklama = p_Aciklama
    WHERE
        odeme_ID = p_OdemeID;
END $$
DELIMITER ;





DELIMITER $$
CREATE PROCEDURE SporM_OdemeGuncelle (
    p_OdemeID   INT,
    p_UyeID     INT,
    p_Tarih     DATETIME,
    p_Miktar    DECIMAL(10, 2),
    p_Aciklama  VARCHAR(255)
)
BEGIN
    UPDATE Odeme
    SET
        uye_ID = p_UyeID,
        tarih = p_Tarih,
        miktar = p_Miktar,
        aciklama = p_Aciklama
    WHERE
        odeme_ID = p_OdemeID;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE SporM_OdemeSil (
    p_OdemeID   INT
)
BEGIN
    DELETE FROM Odeme
    WHERE
        odeme_ID = p_OdemeID;
END $$'%',filtre,'%') ;
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE SporM_OdemeleriListele ()
BEGIN
    SELECT
        odeme_ID,
        uye_ID,
        tarih,
        miktar,
        aciklama
    FROM Odeme;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE SporM_EkipmanEkle (
    p_SporDaliID INT,
    p_Durumu VARCHAR(10),
    p_EkipmanAdi VARCHAR(50)
)
BEGIN
    INSERT INTO ekipman (Spor_Dali_ID, durumu, ekipman_Adi)
    VALUES (p_SporDaliID, p_Durumu, p_EkipmanAdi);
END $$
DELIMITER $$
CREATE PROCEDURE SporM_EkipmanGuncelle (
    p_EkipmanID INT,
    p_SporDaliID INT,
    p_Durumu VARCHAR(10),
    p_EkipmanAdi VARCHAR(50)
)
BEGIN
    UPDATE ekipman
    SET
        Spor_Dali_ID = p_SporDaliID,
        durumu = p_Durumu,
        ekipman_Adi = p_EkipmanAdi
    WHERE
        ekipman_ID = p_EkipmanID;
END $$DELIMITER ;
DELIMITER ;
DELIMITER $$

CREATE PROCEDURE SporM_EkipmanSil (
    p_EkipmanID INT
)
BEGIN
    DELETE FROM ekipman
    WHERE
        ekipman_ID = p_EkipmanID;
END $$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER before_insert_check_unique_tc
BEFORE INSERT ON uye
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM uye WHERE UYE_TC = NEW.UYE_TC) > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Bu T.C. kimlik numarası zaten kullanılmaktadır.';
    END IF;
END $$uye
DELIMITER ;
DELIMITER $$
CREATE TRIGGER before_insert_check_not_null
BEFORE INSERT ON uye
FOR EACH ROW
BEGIN
    IF NEW.UYE_AD IS NULL OR NEW.UYE_SOYAD IS NULL OR NEW.UYE_TELEFON IS NULL OR NEW.UYE_MAIL IS NULL OR NEW.UYE_DOGUM_TARIHI IS NULL OR NEW.KAYIT_TARIHI IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ad, soyad, telefon, e-posta, doğum tarihi ve kayıt tarihi alanları boş bırakılamaz.';
    END IF;
END $$

DELIMITER ;
