def is_num(s):
    ''' 
    is_num("1.1") # True
    is_num("四") # True
    is_num("1e3") # True
    '''
    try:
        float(s)
        return True
    except ValueError:
        pass

    try:
        import unicodedata
        unicodedata.numeric(s)
        return True
    except (ValueError, TypeError):
        pass
    return False


if __name__ == "__main__":
    pass
