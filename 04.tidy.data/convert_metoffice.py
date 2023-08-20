import argparse


def _argparser():
    _parser = argparse.ArgumentParser(description="Convert a Met Office historical station data file into a nice CSV.",
                                      formatter_class=argparse.RawDescriptionHelpFormatter)
    
    _parser.add_argument('txtfile', action='store', type=str, help='the name of the text file to convert.')
    return _parser


def main():
    parser = _argparser()
    args = parser.parse_args()

    # read the txt file, stripping spaces at the beginning/end of lines
    with open(args.txtfile, 'r') as f:
        raw_data = [l.strip() for l in f.readlines()]

    # open the output file, replacing .txt in the input name with .csv
    with open(args.txtfile.replace('.txt', '.csv'), 'w') as f:
        header = ','.join(raw_data[5].split())
        
        nsep = header.count(',') # count the number of commas in the header
        
        print(','.join(raw_data[5].split()), file=f) # print the column header to the file
        
        for line in raw_data[7:]:
            clean_line = line.replace('*', '').replace('#', '') # remove all * and # characters
            clean_line = ','.join(clean_line.split()).replace('---', '') # replace all --- characters after replacing spaces with ,
    
            if clean_line.count(',') == nsep: # this will only write the line if it has the same # of columns as the header
                print(clean_line, file=f)


if __name__ == "__main__":
    main()
