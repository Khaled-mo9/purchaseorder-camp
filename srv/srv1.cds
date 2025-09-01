using khaled.db as db  from '../db/model1';

service PostServ {

    entity Posts as projection on db.Posts;

}