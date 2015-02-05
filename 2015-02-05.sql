#extend the project view with the idlocation column, to make security checks on this data
CREATE 
   or replace
VIEW `project_active` AS
    SELECT 
        `project`.`idProject` AS `idproject`,
        `project`.`ProjectName` AS `ProjectName`,
        idlocation
    FROM
        `project`
    WHERE
        (`project`.`idDataStatus` = 1);
        

#Insert Main Menu "Help"
INSERT INTO `scapp` (idscapp, `scappShort`, `scappName`, `idDataStatus`, `creator`, `hint`, `Icon`, `sortorder`, `isMenu`) VALUES (42, 'Help', 'Help', '1', '1', 'Zelos Help Menu', 'scriptcase__NM__ico__NM__help2_32.png', '95', '1');

#Give the Amin Role Access to the Help Menu
INSERT INTO `scapp_role` (`idscapp`, `idRole`, `creator`, `idDataStatus`) VALUES ('42', '1', '1', '1');

# create a onw reservation task view to provide the periode in the WF Task list for Admins - JIRA 552
CREATE 
   or replace
VIEW `workflowtasks_res` AS
   SELECT `wft`.`objecttypeName`,
    `wft`.`objecttyperef`,
    `wft`.`task`,
    `wft`.`username`,
    `wft`.`email`,
    `wft`.`created`,
    `wft`.`idWFITask`,
    `wft`.`task_iduser`,
    `wft`.`objecttypeshort`,
    `wft`.`idwfinstance`,
     left(p.start_date, 7) period
FROM `workflowtasks` wft
inner join reservation res on wft.objecttyperef = res.idReservation
inner join project p on p.idproject = res.idproject
where wft.objecttypeshort = 'RES';

# recreateion of reservation pivot list JIRA 552
UPDATE `scapp` SET `link`='grid_res_pivot_2' WHERE `idscapp`='37';

# give channel managers access to reservation pivot list - JIRA 555

INSERT INTO `scapp_role` (`idscapp`, `idRole`, `creator`, `idDataStatus`) VALUES ('37', '5', '1', '1');
INSERT INTO `scapp_role` (`idscapp`, `idRole`, `creator`, `idDataStatus`) VALUES ('38', '5', '1', '1');


