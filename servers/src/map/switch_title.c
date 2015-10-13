int clif_updatestate(struct block_list *bl, va_list ap) {
	char buf[64];
	USER *sd = NULL;
	USER *src_sd = NULL;
	int len=0;

	nullpo_ret(0,sd=va_arg(ap,USER*));
	nullpo_ret(0,src_sd=(USER*)bl);

	//if( (sd->optFlags & optFlag_stealth && !src_sd->status.gm_level) && src_sd->status.id != sd->status.id)return 0;
	
	if (!session[sd->fd])
	{
		session[sd->fd]->eof = 8;
		return 0;
	}
	
	WFIFOHEAD(src_sd->fd,512);
	WFIFOB(src_sd->fd,0)=0xAA;
	WFIFOB(src_sd->fd,3)=0x1D;
	//WFIFOB(src_sd->fd,4)=0x03;
	WFIFOL(src_sd->fd,5)=SWAP32(sd->bl.id);
	
	if(sd->status.state==4) {
		WFIFOB(src_sd->fd,9)=1;
		WFIFOB(src_sd->fd,10)=15;
		WFIFOB(src_sd->fd,11)=sd->status.state;
		WFIFOW(src_sd->fd,12)=SWAP16(sd->disguise+32768);
		WFIFOB(src_sd->fd,14)=sd->disguise_color;
		
		if (!strcmpi(sd->status.title, "")) {
			sprintf(buf, "%s", sd->status.name);
		} else {
			//sprintf(buf, "%s %s", sd->status.title, sd->status.name);//dont show title to name
		    sprintf(buf, "%s", sd->status.name);
		}
		
		WFIFOB(src_sd->fd,16)=strlen(buf);
		len+=strlen(sd->status.name)+1;
		strcpy(WFIFOP(src_sd->fd,17),buf);

		WFIFOW(src_sd->fd,1)=SWAP16(len+13);
		WFIFOSET(src_sd->fd,encrypt(src_sd->fd));
	} else {
		WFIFOW(src_sd->fd,9)=SWAP16(sd->status.sex);
		
		if((sd->status.state == 2 || (sd->optFlags & optFlag_stealth)) && sd->bl.id != src_sd->bl.id && (src_sd->status.gm_level || clif_isingroup(src_sd, sd) || (sd->bl.m >= 7010 && sd->bl.m <= 7050 && sd->status.armor_color == src_sd->status.armor_color))) {
			WFIFOB(src_sd->fd,11)=5; //Gm's need to see invis
		} else {
			WFIFOB(src_sd->fd,11)=sd->status.state;
		}

      	if((sd->optFlags & optFlag_stealth) && !sd->status.state && !src_sd->status.gm_level)WFIFOB(src_sd->fd,11)=2;

		if(sd->status.state==3) {
			WFIFOW(src_sd->fd,12)=SWAP16(sd->disguise);
		} else {
			WFIFOW(src_sd->fd,12)=SWAP16(0);
		}

		WFIFOB(src_sd->fd,14)=sd->speed;
		WFIFOB(src_sd->fd, 15) = 0;
		WFIFOB(src_sd->fd, 16) = sd->status.face; //face
		WFIFOB(src_sd->fd, 17) = sd->status.hair; //hair
		WFIFOB(src_sd->fd, 18) = sd->status.hair_color; //hair color
		WFIFOB(src_sd->fd, 19) = sd->status.face_color;
		WFIFOB(src_sd->fd, 20) =sd->status.skin_color;
		//WFIFOB(src_sd->fd,21)=0;

	//armor
		if (!pc_isequip(sd, EQ_ARMOR)) {
			WFIFOW(src_sd->fd, 21) = SWAP16(sd->status.sex);
		} else {
			WFIFOW(src_sd->fd, 21) = SWAP16(itemdb_look(pc_isequip(sd, EQ_ARMOR)));//-10000+16;
			
			if(sd->status.armor_color>0) {
				WFIFOB(src_sd->fd,23)=	sd->status.armor_color;
			} else {
				WFIFOB(src_sd->fd,23)=itemdb_lookcolor(pc_isequip(sd,EQ_ARMOR));
			}
		}
	  
	//coat
		if(pc_isequip(sd,EQ_COAT)) {
			WFIFOW(src_sd->fd,21)=SWAP16(itemdb_look(pc_isequip(sd,EQ_COAT)));//-10000+16;
			WFIFOB(src_sd->fd, 23) = itemdb_lookcolor(pc_isequip(sd,EQ_COAT));
		}

	//weapon
		if (!pc_isequip(sd, EQ_WEAP)) {
			WFIFOW(src_sd->fd, 24) =0xFFFF;
			WFIFOB(src_sd->fd,26)=0x0;
		} else {
			WFIFOW(src_sd->fd, 24) = SWAP16(itemdb_look(pc_isequip(sd, EQ_WEAP)));
			WFIFOB(src_sd->fd, 26) = itemdb_lookcolor(pc_isequip(sd, EQ_WEAP));
		}
	//shield
		if (!pc_isequip(sd, EQ_SHIELD)) {
			WFIFOW(src_sd->fd, 27) = 0xFFFF;
			WFIFOB(src_sd->fd, 29) = 0;
		} else {
			WFIFOW(src_sd->fd, 27) = SWAP16(itemdb_look(pc_isequip(sd, EQ_SHIELD)));
			WFIFOB(src_sd->fd, 29) = itemdb_lookcolor(pc_isequip(sd, EQ_SHIELD));
		}

		if (!pc_isequip(sd,EQ_HELM) || !(sd->status.settingFlags & FLAG_HELM) || (itemdb_look(pc_isequip(sd,EQ_HELM))==-1)) {
		//helm stuff goes here
			WFIFOB(src_sd->fd, 30)=0; // supposed to be 1=Helm, 0=No helm
			WFIFOW(src_sd->fd, 31)=0xFFFF; // supposed to be Helm num
		} else {
			WFIFOB(src_sd->fd, 30)=1;
			WFIFOB(src_sd->fd, 31)=itemdb_look(pc_isequip(sd,EQ_HELM));
			WFIFOB(src_sd->fd, 32)=itemdb_lookcolor(pc_isequip(sd,EQ_HELM));
		}
	//faceacc
		if (!pc_isequip(sd,EQ_FACEACC)) {
	//beard stuff
			WFIFOW(src_sd->fd, 33)=0xFFFF;
			WFIFOB(src_sd->fd, 35)=0x0;
		} else {
			WFIFOW(src_sd->fd, 33)=SWAP16(itemdb_look(pc_isequip(sd,EQ_FACEACC))); //beard num
			WFIFOB(src_sd->fd, 35)=itemdb_lookcolor(pc_isequip(sd,EQ_FACEACC)); //beard color
		}
	//crown
		if (!pc_isequip(sd,EQ_CROWN)) {
			WFIFOW(src_sd->fd, 36)=0xFFFF;
			WFIFOB(src_sd->fd, 38)=0x0;
		} else {
			WFIFOB(src_sd->fd, 30)=0;
			WFIFOW(src_sd->fd, 36)=SWAP16(itemdb_look(pc_isequip(sd,EQ_CROWN))); //Crown
			WFIFOB(src_sd->fd, 38)=itemdb_lookcolor(pc_isequip(sd,EQ_CROWN)); //Crown color
		}
	
		if (!pc_isequip(sd, EQ_FACEACCTWO)) {
			WFIFOW(src_sd->fd, 39)=0xFFFF; //second face acc
			WFIFOB(src_sd->fd,41)=0x0; //" color
		} else {
			WFIFOW(src_sd->fd, 39) = SWAP16(pc_isequip(sd, EQ_FACEACCTWO));
			WFIFOB(src_sd->fd, 41) = sd->status.equip[EQ_FACEACCTWO].custom;
		}
		
	//mantle
		if (!pc_isequip(sd,EQ_MANTLE)) {
			WFIFOW(src_sd->fd, 42)=0xFFFF;
			WFIFOB(src_sd->fd, 44)=0xFF;
		} else {
			WFIFOW(src_sd->fd, 42)=SWAP16(itemdb_look(pc_isequip(sd,EQ_MANTLE)));
			WFIFOB(src_sd->fd, 44)=itemdb_lookcolor(pc_isequip(sd,EQ_MANTLE));
		}
	//necklace
		if (!pc_isequip(sd,EQ_NECKLACE)) {
			WFIFOW(src_sd->fd,45)=0xFFFF;
			WFIFOB(src_sd->fd,47)=0x0;
		} else {
			WFIFOW(src_sd->fd, 45)=SWAP16(itemdb_look(pc_isequip(sd,EQ_NECKLACE))); //necklace
			WFIFOB(src_sd->fd, 47)=itemdb_lookcolor(pc_isequip(sd,EQ_NECKLACE)); //neckalce color
		}
	//boots
		if (!pc_isequip(sd,EQ_BOOTS)) {
			WFIFOW(src_sd->fd, 48)=SWAP16(sd->status.sex); //boots
			WFIFOB(src_sd->fd,50)=0x0;
		} else {
			WFIFOW(src_sd->fd,48)=SWAP16(itemdb_look(pc_isequip(sd,EQ_BOOTS)));
			WFIFOB(src_sd->fd,50)=itemdb_lookcolor(pc_isequip(sd,EQ_BOOTS));
		}

		WFIFOB(src_sd->fd,51)=0;
		
		if (!strcmpi(sd->status.title, "")) {
			sprintf(buf, "%s", sd->status.name);
		} else {
			//sprintf(buf, "%s %s", sd->status.title, sd->status.name);//dont show title to name
		    sprintf(buf, "%s", sd->status.name);
		}
		
		len = strlen(buf);
	
		if(src_sd->status.clan_id==sd->status.clan_id) {
			if(src_sd->status.clan_id>0) {
				if(src_sd->status.id!=sd->status.id) {
					WFIFOB(src_sd->fd,51)=3;
				}
			}
		}
		
		if(clif_isingroup(src_sd,sd)) {
			if(sd->status.id!=src_sd->status.id) {
				WFIFOB(src_sd->fd,51)=2;
			}
		}
		//if(sd->status.gm_level>1) {
	//		WFIFOB(src_sd->fd,56)=1;
	//	}*/
		//WFIFOB(src_sd->fd,51)=WFIFOB;
		if((sd->status.state!=5) && (sd->status.state!=2)) {
			WFIFOB(src_sd->fd, 52) = len;
			strcpy(WFIFOP(src_sd->fd, 53), buf);
		} else {
			WFIFOB(src_sd->fd,52)=0;
			len=0;
		}
		
		if((sd->status.gm_level && sd->gfx.toggle) || sd->clone) {
			WFIFOB(src_sd->fd, 16) = sd->gfx.face;
			WFIFOB(src_sd->fd, 17) = sd->gfx.hair;
			WFIFOB(src_sd->fd, 18) = sd->gfx.chair;
			WFIFOB(src_sd->fd, 19) = sd->gfx.cface;
			WFIFOB(src_sd->fd, 20) = sd->gfx.cskin;
			WFIFOW(src_sd->fd,21)=SWAP16(sd->gfx.armor);
			if (sd->gfx.dye > 0) {
				WFIFOB(src_sd->fd, 23) = sd->gfx.dye;
			} else {
				WFIFOB(src_sd->fd,23)=sd->gfx.carmor;
			}
			WFIFOW(src_sd->fd,24)=SWAP16(sd->gfx.weapon);
			WFIFOB(src_sd->fd,26)=sd->gfx.cweapon;
			WFIFOW(src_sd->fd,27)=SWAP16(sd->gfx.shield);
			WFIFOB(src_sd->fd,29)=sd->gfx.cshield;
			
			if (sd->gfx.helm < 255) {
				WFIFOB(src_sd->fd, 30) = 1;
			} else if (sd->gfx.crown < 65535) {
				WFIFOB(src_sd->fd, 30) = 0xFF;
			} else {
				WFIFOB(src_sd->fd, 30) = 0;
			}
			
			WFIFOB(src_sd->fd,31)=sd->gfx.helm;
			WFIFOB(src_sd->fd,32)=sd->gfx.chelm;
			WFIFOW(src_sd->fd,33)=SWAP16(sd->gfx.faceAcc);
			WFIFOB(src_sd->fd,35)=sd->gfx.cfaceAcc;
			WFIFOW(src_sd->fd,36)=SWAP16(sd->gfx.crown);
			WFIFOB(src_sd->fd,38)=sd->gfx.ccrown;
			WFIFOW(src_sd->fd,39)=SWAP16(sd->gfx.faceAccT);
			WFIFOB(src_sd->fd,41)=sd->gfx.cfaceAccT;
			WFIFOW(src_sd->fd,42)=SWAP16(sd->gfx.mantle);
			WFIFOB(src_sd->fd,44)=sd->gfx.cmantle;
			WFIFOW(src_sd->fd,45)=SWAP16(sd->gfx.necklace);
			WFIFOB(src_sd->fd,47)=sd->gfx.cnecklace;
			WFIFOW(src_sd->fd,48)=SWAP16(sd->gfx.boots);
			WFIFOB(src_sd->fd,50)=sd->gfx.cboots;
			len = strlen(sd->gfx.name);
			if (strcmpi(sd->gfx.name, "")) {
				WFIFOB(src_sd->fd, 52) = len;
				strcpy(WFIFOP(src_sd->fd, 53), sd->gfx.name);
			} else {
				WFIFOW(src_sd->fd,52) = 0;
				len = 1;
			}
		}

		WFIFOW(src_sd->fd, 1) = SWAP16(len+51);
		WFIFOSET(src_sd->fd, encrypt(src_sd->fd));
	}
	
	if(map[sd->bl.m].show_ghosts) {
		if(sd->status.state==1 && (src_sd->bl.id!=sd->bl.id)) {
			if(src_sd->status.state!=1 && !(src_sd->optFlags & optFlag_ghosts)) {
				WFIFOB(src_sd->fd, 0) = 0xAA;
				WFIFOB(src_sd->fd, 1) = 0x00;
				WFIFOB(src_sd->fd, 2) = 0x06;
				WFIFOB(src_sd->fd, 3) = 0x0E;
				WFIFOB(src_sd->fd, 4) = 0x03;
				WFIFOL(src_sd->fd, 5) = SWAP32(sd->bl.id);
				WFIFOSET(src_sd->fd,encrypt(src_sd->fd));

			//clif_getchararea(sd);
			//clif_sendchararea(sd);
			//clif_lookgone(&sd->bl);
				return 0;
			} else {
				clif_charspecific(src_sd->bl.id,sd->bl.id);
			}

		/*} else if(sd->status.state==0 && (src_sd->bl.id!=sd->bl.id)) {
			if(src_sd->status.state==1) {
				WFIFOB(sd->fd, 0) = 0xAA;
				WFIFOB(sd->fd, 1) = 0x00;
				WFIFOB(sd->fd, 2) = 0x06;
				WFIFOB(sd->fd, 3) = 0x5F;
				WFIFOB(sd->fd, 4) = 0x03;
				WFIFOL(sd->fd, 5) = SWAP32(src_sd->bl.id);
				encrypt(WFIFOP(sd->fd,0));
				WFIFOSET(sd->fd,9);
			} */
		}
	}
	/*if(src_sd->bl.id==sd->bl.id) {
		pc_warp(sd,sd->bl.m,sd->bl.x,sd->bl.y);
	}*/
	return 0;
}



int clif_charlook_sub(struct block_list *bl, va_list ap) {
	char buf[64];
	USER *src_sd = NULL;
	USER *sd = NULL;
	int x, len, type;
	int exist = -1;
	
	type=va_arg(ap, int);

	if (type==LOOK_GET) {
		nullpo_ret(0, sd=(USER*)bl);
		nullpo_ret(0, src_sd=va_arg(ap,USER*));
		if (src_sd==sd)
			return 0;
	} else {
		nullpo_ret(0, src_sd=(USER*)bl);
		nullpo_ret(0, sd=va_arg(ap,USER*));
	}

	if(sd->bl.m!=src_sd->bl.m) return 0; //Hopefully this'll cure seeing ppl on the map who arent there.

	if((sd->optFlags & optFlag_stealth) && !src_sd->status.gm_level && (sd->status.id != src_sd->status.id))
		return 0;

	if(map[sd->bl.m].show_ghosts && sd->status.state==1 && (sd->bl.id!=src_sd->bl.id)) {
		if(src_sd->status.state!=1 && !(src_sd->optFlags & optFlag_ghosts)) {
			return 0;
		}
	}
	
	if (!session[sd->fd])
	{
		session[sd->fd]->eof = 8;
		return 0;
	}
	
	WFIFOHEAD(src_sd->fd,512);
	WFIFOB(src_sd->fd, 0) = 0xAA;
	WFIFOB(src_sd->fd, 3) = 0x33;
	//WFIFOB(src_sd->fd, 4) = 0x03;
	WFIFOW(src_sd->fd, 5) = SWAP16(sd->bl.x);
	WFIFOW(src_sd->fd, 7) = SWAP16(sd->bl.y);
	WFIFOB(src_sd->fd, 9) = sd->status.side;
	WFIFOL(src_sd->fd, 10) = SWAP32(sd->status.id);
	
	if(sd->status.state < 4) {
		WFIFOW(src_sd->fd, 14) = SWAP16(sd->status.sex);
	} else {
		WFIFOB(src_sd->fd, 14) = 1;
		WFIFOB(src_sd->fd, 15) = 15;
	}
	
	if ((sd->status.state == 2 || (sd->optFlags & optFlag_stealth)) && sd->bl.id != src_sd->bl.id && (src_sd->status.gm_level || clif_isingroup(src_sd, sd))) {
		WFIFOB(src_sd->fd,16)=5; //Gm's need to see invis
	} else {
		WFIFOB(src_sd->fd,16)=sd->status.state;
	}

	if((sd->optFlags & optFlag_stealth) && !sd->status.state && (!src_sd->status.gm_level || sd->bl.id == src_sd->bl.id))
		WFIFOB(src_sd->fd,16)=2;

	WFIFOB(src_sd->fd, 19) = sd->speed;

	if(sd->status.state==3) {
		WFIFOW(src_sd->fd, 17) = SWAP16(sd->disguise);
	//WFIFOB(src_sd->fd,19)=sd->disguise_color;
	} else if(sd->status.state==4) {
		WFIFOW(src_sd->fd,17)=SWAP16(sd->disguise+32768);
		WFIFOB(src_sd->fd,19)=sd->disguise_color;
	} else {
		WFIFOW(src_sd->fd,17)=SWAP16(0);
		//WFIFOB(src_sd->fd,19)=0;
	}

	WFIFOB(src_sd->fd, 20) = 0;
	//if(sd->status.gm_level) WFIFOB(src_sd->fd,20)=val[0];
	WFIFOB(src_sd->fd, 21) = sd->status.face; //face
	WFIFOB(src_sd->fd, 22) = sd->status.hair; //hair
	WFIFOB(src_sd->fd, 23) = sd->status.hair_color; //hair color
	WFIFOB(src_sd->fd, 24) = sd->status.face_color;
	WFIFOB(src_sd->fd, 25) = sd->status.skin_color;
	//WFIFOB(src_sd->fd,26)=0;

	//armor
    if (!pc_isequip(sd, EQ_ARMOR)) {
			WFIFOW(src_sd->fd, 26) = SWAP16(sd->status.sex);
	} else {
		WFIFOW(src_sd->fd, 26) = SWAP16(itemdb_look(pc_isequip(sd, EQ_ARMOR)));

		if(sd->status.armor_color>0) {
			WFIFOB(src_sd->fd,28)=	sd->status.armor_color;
		} else {
			WFIFOB(src_sd->fd,28)=itemdb_lookcolor(pc_isequip(sd,EQ_ARMOR));
		}

	}
	if(pc_isequip(sd,EQ_COAT)) {
		WFIFOW(src_sd->fd,26)=SWAP16(itemdb_look(pc_isequip(sd,EQ_COAT)));
		WFIFOB(src_sd->fd, 28) = itemdb_lookcolor(pc_isequip(sd,EQ_COAT));
      }

	//weapon
	if (!pc_isequip(sd, EQ_WEAP)) {
		WFIFOW(src_sd->fd, 29) =0xFFFF;
		WFIFOB(src_sd->fd,31)=0x0;
	} else {
		WFIFOW(src_sd->fd, 29) = SWAP16(itemdb_look(pc_isequip(sd, EQ_WEAP)));
		WFIFOB(src_sd->fd, 31) = itemdb_lookcolor(pc_isequip(sd, EQ_WEAP));
	}
//shield
	if (!pc_isequip(sd, EQ_SHIELD)) {
		WFIFOW(src_sd->fd, 32) = 0xFFFF;
		WFIFOB(src_sd->fd, 34) = 0;
	} else {
		WFIFOW(src_sd->fd, 32) = SWAP16(itemdb_look(pc_isequip(sd, EQ_SHIELD)));
		WFIFOB(src_sd->fd, 34) = itemdb_lookcolor(pc_isequip(sd, EQ_SHIELD));
	}

	if (!pc_isequip(sd,EQ_HELM) || !(sd->status.settingFlags & FLAG_HELM) || (itemdb_look(pc_isequip(sd,EQ_HELM))==-1)) {
	//helm stuff goes here
		WFIFOB(src_sd->fd, 35)=0; // supposed to be 1=Helm, 0=No helm
		WFIFOW(src_sd->fd, 36)=0xFF; // supposed to be Helm num
    } else {
		WFIFOB(src_sd->fd, 35)=1;
		WFIFOB(src_sd->fd, 36)=itemdb_look(pc_isequip(sd,EQ_HELM));
		WFIFOB(src_sd->fd, 37)=itemdb_lookcolor(pc_isequip(sd,EQ_HELM));
	}

	if (!pc_isequip(sd,EQ_FACEACC)) {
	//beard stuff
		WFIFOW(src_sd->fd, 38)=0xFFFF;
		WFIFOB(src_sd->fd, 40)=0;
	} else {
		WFIFOW(src_sd->fd, 38)=SWAP16(itemdb_look(pc_isequip(sd,EQ_FACEACC))); //beard num
		WFIFOB(src_sd->fd, 40)=itemdb_lookcolor(pc_isequip(sd,EQ_FACEACC)); //beard color
	}
	//crown
	if (!pc_isequip(sd,EQ_CROWN)) {
		WFIFOW(src_sd->fd, 41)=0xFFFF;
		WFIFOB(src_sd->fd, 43)=0;
	} else {
		WFIFOB(src_sd->fd, 35)=0xFF;
		WFIFOW(src_sd->fd, 41)=SWAP16(itemdb_look(pc_isequip(sd,EQ_CROWN))); //Crown
		WFIFOB(src_sd->fd, 43)=itemdb_lookcolor(pc_isequip(sd,EQ_CROWN)); //Crown color
	}
	
	if (!pc_isequip(sd, EQ_FACEACCTWO)) {
		WFIFOW(src_sd->fd, 44)=0xFFFF; //second face acc
		WFIFOB(src_sd->fd,46)=0; //" color
	} else {
		WFIFOW(src_sd->fd, 44) = SWAP16(pc_isequip(sd, EQ_FACEACCTWO));
		WFIFOB(src_sd->fd, 46) = sd->status.equip[EQ_FACEACCTWO].custom;
	}

	if (!pc_isequip(sd,EQ_MANTLE)) {
		WFIFOW(src_sd->fd, 47)=0xFFFF;
		WFIFOB(src_sd->fd, 49)=0xFF;
	} else {
		WFIFOW(src_sd->fd, 47)=SWAP16(itemdb_look(pc_isequip(sd,EQ_MANTLE)));
		WFIFOB(src_sd->fd, 49)=itemdb_lookcolor(pc_isequip(sd,EQ_MANTLE));
	}
	if (!pc_isequip(sd,EQ_NECKLACE)) {
		WFIFOW(src_sd->fd,50)=0xFFFF;
		WFIFOB(src_sd->fd,52)=0;
	} else {
		WFIFOW(src_sd->fd, 50)=SWAP16(itemdb_look(pc_isequip(sd,EQ_NECKLACE))); //necklace
		WFIFOB(src_sd->fd, 52)=itemdb_lookcolor(pc_isequip(sd,EQ_NECKLACE)); //neckalce color
	}
	if (!pc_isequip(sd,EQ_BOOTS)) {
		WFIFOW(src_sd->fd, 53)=SWAP16(sd->status.sex); //boots
		WFIFOB(src_sd->fd,55)=0;
	} else {
		WFIFOW(src_sd->fd,53)=SWAP16(itemdb_look(pc_isequip(sd,EQ_BOOTS)));
		WFIFOB(src_sd->fd,55)=itemdb_lookcolor(pc_isequip(sd,EQ_BOOTS));
	}

		WFIFOB(src_sd->fd,56)=0;
		
		if (!strcmpi(sd->status.title, "")) {
			sprintf(buf, "%s", sd->status.name);
		} else {
			//sprintf(buf, "%s %s", sd->status.title, sd->status.name);//dont show title to name
		    sprintf(buf, "%s", sd->status.name);
		}
		
		len = strlen(buf);
		
		if(src_sd->status.clan_id==sd->status.clan_id) {
			if(src_sd->status.clan_id>0) {
				if(src_sd->status.id!=sd->status.id) {
					WFIFOB(src_sd->fd,56)=3;
				}
			}
		}

		if(clif_isingroup(src_sd,sd)) {
			WFIFOB(src_sd->fd,56)=2;
		}
		
		for (x = 0; x < 20; x++) {
			if (src_sd->pvp[x][0] == sd->bl.id) {
				exist = x;
				break;
			}
		}
		
		if (sd->status.pk > 0 || exist != -1) {
			WFIFOB(src_sd->fd, 56) = 1;
		}

		if((sd->status.state!=2) && (sd->status.state!=5)) {
			WFIFOB(src_sd->fd, 57) = len;
			strcpy(WFIFOP(src_sd->fd, 58), buf);
		} else {
			WFIFOB(src_sd->fd,57)=0;
			len=0;
		}
		//WFIFOB(src_sd->fd,len+58)=1;
		//WFIFOW(src_sd->fd,len+59)=SWAP16(5);
		//WFIFOW(src_sd->fd,len+61)=SWAP16(10);

	if((sd->status.gm_level && sd->gfx.toggle) || sd->clone) {
		WFIFOB(src_sd->fd, 21) = sd->gfx.face;
		WFIFOB(src_sd->fd, 22) = sd->gfx.hair;
		WFIFOB(src_sd->fd, 23) = sd->gfx.chair;
		WFIFOB(src_sd->fd, 24) = sd->gfx.cface;
		WFIFOB(src_sd->fd, 25) = sd->gfx.cskin;
		WFIFOW(src_sd->fd,26)=SWAP16(sd->gfx.armor);
		if (sd->gfx.dye > 0) {
			WFIFOB(src_sd->fd, 28) = sd->gfx.dye;
		} else {
			WFIFOB(src_sd->fd,28)=sd->gfx.carmor;
		}
		WFIFOW(src_sd->fd,29)=SWAP16(sd->gfx.weapon);
		WFIFOB(src_sd->fd,31)=sd->gfx.cweapon;
		WFIFOW(src_sd->fd,32)=SWAP16(sd->gfx.shield);
		WFIFOB(src_sd->fd,34)=sd->gfx.cshield;
		
		if (sd->gfx.helm < 255) {
			WFIFOB(src_sd->fd, 35) = 1;
		} else if (sd->gfx.crown < 65535) {
			WFIFOB(src_sd->fd, 35) = 0xFF;
		} else {
			WFIFOB(src_sd->fd, 35) = 0;
		}
		
		WFIFOB(src_sd->fd,36)=sd->gfx.helm;
		WFIFOB(src_sd->fd,37)=sd->gfx.chelm;
		WFIFOW(src_sd->fd,38)=SWAP16(sd->gfx.faceAcc);
		WFIFOB(src_sd->fd,40)=sd->gfx.cfaceAcc;
		WFIFOW(src_sd->fd,41)=SWAP16(sd->gfx.crown);
		WFIFOB(src_sd->fd,43)=sd->gfx.ccrown;
		WFIFOW(src_sd->fd,44)=SWAP16(sd->gfx.faceAccT);
		WFIFOB(src_sd->fd,46)=sd->gfx.cfaceAccT;
		WFIFOW(src_sd->fd,47)=SWAP16(sd->gfx.mantle);
		WFIFOB(src_sd->fd,49)=sd->gfx.cmantle;
		WFIFOW(src_sd->fd,50)=SWAP16(sd->gfx.necklace);
		WFIFOB(src_sd->fd,52)=sd->gfx.cnecklace;
		WFIFOW(src_sd->fd,53)=SWAP16(sd->gfx.boots);
		WFIFOB(src_sd->fd,55)=sd->gfx.cboots;
		len = strlen(sd->gfx.name);
		if (strcmpi(sd->gfx.name, "")) {
			WFIFOB(src_sd->fd, 57) = len;
			strcpy(WFIFOP(src_sd->fd, 58), sd->gfx.name);
		} else {
			WFIFOW(src_sd->fd,57) = 0;
			len = 1;
		}
	}

	WFIFOW(src_sd->fd, 1) = SWAP16(len+55);
	WFIFOSET(src_sd->fd, encrypt(src_sd->fd));

	clif_sendanimations(src_sd,sd);

	return 0;
}


/*
	char reg[] = "show_title";
	int show = 0'

	if (!strcmpi(sd->status.title, "")) {
		sprintf(buf, "%s", sd->status.name);
	} else {
		show = pc_readglobalreg(sd, reg);
		if (show > 0) {
			sprintf(buf, "%s %s", sd->status.title, sd->status.name);
			//clif_parserefresh(sd);
		} else {
			sprintf(buf, "%s", sd->status.name);
		}
	}
	
*/