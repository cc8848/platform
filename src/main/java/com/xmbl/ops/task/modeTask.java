package com.xmbl.ops.task;
//@Component
public class modeTask {
//	private static Logger logger = LoggerFactory.getLogger("xmbl_task_log");
//	private final static Integer limit =100;
//	@Resource
//	IOrcBookRatesDao orcBookRatesDao;
//	@Resource
//	IOrcBooksDao orcBooksDao;
//	@Resource
//	IOrcPictureDao orcPictureDao;		
//
//	// 凌晨4点执行
//	@Scheduled(cron = "1 1 4 * * ? ")
//	private void statisticBooksRecognition() {
//		logger.info("[BEGIN] statisticBooksRecognition");
//		Long id=null;
//		List<OrcBooks> orcBooksList=null;
//		List<OrcBookRates> updateOrcBookRatesList = new ArrayList<>();
//		List<OrcBookRates> newOrcBookRatesList = new ArrayList<>();
//		try {
//			do {
//				orcBooksList  = orcBooksDao.searchAllList(id, limit);
//				if( orcBooksList != null && orcBooksList.size() > 0 ) {
//					List<OrcAnalysisByBook> orcAnalysisByBook=null;
//					updateOrcBookRatesList.clear();
//					newOrcBookRatesList.clear();
//
//					for( OrcBooks orcBook : orcBooksList ) {
//						Long successCNT =0L;
//						Long totalCNT =0L;
//						Long undealCNT =0L;							
//						String  orcRate = "";
//						orcAnalysisByBook = orcPictureDao.countBookByStatus(orcBook.getBookid());
//						if( orcAnalysisByBook != null && orcAnalysisByBook.size() > 0) {
//							for(OrcAnalysisByBook countList : orcAnalysisByBook ) {
//								if( countList.getStatus() == 1 ) {
//									successCNT +=countList.getCnt();
//								} else if ( countList.getStatus() == 0 ) {
//									undealCNT +=countList.getCnt();
//								} 
//								totalCNT +=countList.getCnt();;
//							}
//							if(totalCNT - undealCNT > 0) {
//								double percent =successCNT*1.0/ ( totalCNT - undealCNT);
//								orcRate = String.format("%1$.2f",percent*100);
//							}
//						}
//						id = orcBook.getId();//最后一条orcBook id
//						OrcBookRates orcBookRates=null;
//
//						if( orcBook.getOrcBookRatesId() != null ) {
//							orcBookRates = new OrcBookRates( orcBook.getOrcBookRatesId(), null, successCNT, undealCNT, totalCNT, orcRate, null );
//							updateOrcBookRatesList.add(orcBookRates);
//						} else {
//							orcBookRates = new OrcBookRates( null, orcBook.getBookid(), successCNT, undealCNT, totalCNT, orcRate, new Date() );
//							newOrcBookRatesList.add(orcBookRates);
//						}
//					}
//					//插入
//					if(updateOrcBookRatesList.size() > 0) {
//						OrcBookRates[] updateOrcBookRatesArray = new OrcBookRates[updateOrcBookRatesList.size()];
//						updateOrcBookRatesList.toArray(updateOrcBookRatesArray);
//						orcBookRatesDao.updateIfNecessary(updateOrcBookRatesArray);
//					}
//					//更新
//					if(newOrcBookRatesList.size() > 0) {
//						OrcBookRates[] newOrcBookRatesArray = new OrcBookRates[newOrcBookRatesList.size()];
//						newOrcBookRatesList.toArray(newOrcBookRatesArray);
//						orcBookRatesDao.insertSelective(newOrcBookRatesArray);
//					}
//				}
//
//				if( orcBooksList == null || orcBooksList.size() < limit) {
//					break;
//				}
//			}while(true);
//
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//
//		logger.info("[END] statisticBooksRecognition ");
//	}
}
